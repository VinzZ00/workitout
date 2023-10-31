//
//  DataManager.swift
//  WorkItOut
//
//  Created by Jeremy Raymond on 31/10/23.
//

import Foundation
import CoreData

class DataManager: ObservableObject {
    let pm: PoseManager = PoseManager()
    var profile: Profile
    
    init() {
        profile = Profile(name: "", currentWeek: Date.now, currentRelieveNeeded: [], fitnessLevel: .beginner, daysAvailable: [], timeOfDay: .morning, preferredDuration: .fiveteenMinutes, plan: [], histories: [])
    }
    
    public func createProfile(name: String, currentWeek: Date, currentRelieveNeeded: [Relieve], fitnessLevel: Difficulty, daysAvailable: [Day], timeOfDay: TimeOfDay, preferredDuration: Duration, plan: [YogaPlan], histories: [History]) -> Profile {
        
        let profile: Profile = Profile(name: name, currentWeek: currentWeek, currentRelieveNeeded: currentRelieveNeeded, fitnessLevel: fitnessLevel, daysAvailable: daysAvailable, timeOfDay: timeOfDay, preferredDuration: preferredDuration, plan: plan, histories: histories)
        
        self.profile = profile
        
        return profile
    }
    
    public func createYogas(days: [Day]) -> [Yoga] {
        var yogas: [Yoga] = []
        
        for day in days {
            yogas.append(Yoga(name: "Test Yoga Name", poses: [], day: day, estimationDuration: 3, image: "ExampleImage.png"))
        }
        
        return yogas
    }
    
    public func createYogaPlan(context: NSManagedObjectContext) -> YogaPlan {
        let yogaPlan: YogaPlan = YogaPlan(name: "Yoga Plan Name", yogas: createYogas(days: [.friday]), trimester: .second)
//        var yogas : [Yoga] = []
        yogaPlan.yogas = [
            var yoga = YogaNSObject(context: context)
                yoga.
        ]
//        yogaPlan.yogas.map { yogaNS in
//            yoga = Yoga(name: yogaNS.name!, poses: (yogaNS.poses?.allObjects as [PoseNSObject]).map{$0.intoPose()}, day: <#T##Day#>, estimationDuration: <#T##Int#>, image: <#T##String#>)
//        }
        return yogaPlan
    }
}

extension PoseNSObject {
    func intoPose() -> Pose {
        return Pose(name: self.name!, description: <#T##String#>, seconds: <#T##Int#>, state: <#T##YogaState#>, position: <#T##Position#>, spineMovement: <#T##SpineMovement#>, recommendedTrimester: <#T##Trimester#>, bodyPartTrained: <#T##[BodyPart]#>, relieve: <#T##[Relieve]#>, difficulty: <#T##Difficulty#>)
    }
}
