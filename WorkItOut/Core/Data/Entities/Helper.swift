//
//  helper.swift
//  WorkItOut
//
//  Created by Elvin Sestomi on 30/10/23.
//

import Foundation
import CoreData

protocol Entity {
    
}

extension PoseNSObject {
    func intoObject() -> Pose {
        var pose = Pose(
            id : self.uuid!,
            name: self.name!,
            altName: self.altName!,
            category: Category(rawValue: self.category!)!, 
            difficulty: Difficulty(rawValue: self.difficulty!)!,
            exception: self.exception!.split(separator: ", ").map{Exception(rawValue: String($0))!},
            recommendedTrimester: Trimester(rawValue: self.recommendedTrimester!)!, 
            relieve: self.relieve!.split(separator: ", ").map{Relieve(rawValue: String($0))!}, 
            description: self.poseDescription!,
            seconds: Int(self.seconds),
            state: YogaState(rawValue: self.state!)!
        ) //Pose
        if self.video != nil {
            pose.video = self.video
        }
        return pose
    }
}

extension YogaNSObject {
    func intoObject() -> Yoga {
        let yoga = Yoga(
            id: self.uuid!,
            name: self.name!,
            poses: (self.poses!.allObjects as? [PoseNSObject] ?? []).map{$0.intoObject()},
            day: Day(rawValue: self.day!)!,
            estimationDuration: Int(self.estimationDuration),
            yogaState: YogaState(rawValue: self.yogaState!)!,
            image: self.image!
        ) // Yoga
        return yoga;
    }
}

extension YogaPlanNSObject {
    func intoObject() -> YogaPlan {
        var yogaPlan = YogaPlan(
            id: self.uuid!,
            name: self.name!,
            trimester: Trimester(rawValue: self.trimester!)!
        ) // YogaPlan
        
        yogaPlan.yogas.append(contentsOf: (self.yogas!.allObjects as? [YogaNSObject] ?? []).map{$0.intoObject()})
        
        return yogaPlan
    }
}

extension HistoryNSObject {
    
    // MARK: Update Elvin 4 Nov
    func addingYogaHist(yogaNS : YogaNSObject) {
        self.yogaDone = yogaNS
    }
    
    func intoObject() -> History {
        let history = History(
            id: self.uuid!,
            // MARK: Change by Elvin 4 Nov, untuk meganti History menjadi HistoryNSObject
            yogaDone: (self.yogaDone?.intoObject())!,
            executionDate: self.executionDate!,
            duration: Int(self.duration),
            rating: Int(self.rating)
        ) // History
        return history
    }
}

extension ProfileNSObject {
    func intoObject() -> Profile {
        var profile = Profile(name: self.name!,
                              currentPregnancyWeek: Int(self.currentPregnancyWeek),
                              currentRelieveNeeded: self.currentRelieveNeeded!.split(separator: ", ").map{Relieve(rawValue: String($0))!},
                              fitnessLevel: Difficulty(rawValue: self.fitnessLevel!)!,
                              daysAvailable: self.daysAvailable!.split(separator: ", ").map{Day(rawValue: String($0))!},
                              timeOfDay: TimeOfDay(rawValue: self.timeOfDay!)!,
                              preferredDuration: Duration(rawValue: self.preferredDuration!)!,
                              plan: (self.plan!.allObjects as? [YogaPlanNSObject] ?? []).map{$0.intoObject()},
                              histories: (self.histories!.allObjects as? [HistoryNSObject] ?? []).map{$0.intoObject()},
                              exceptions: []
        ) // Profile
        
        if let exc = self.exceptions {
            exc.split(separator: ", ").forEach { rawVal in
                let e = Exception(rawValue: String(rawVal))
                if let ex = e {
                    profile.exceptions.append(ex)
                }
            }
        }
        
        return profile
    }
}
