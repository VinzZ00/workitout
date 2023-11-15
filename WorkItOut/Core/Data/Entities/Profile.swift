//
//  Profile.swift
//  WorkItOut
//
//  Created by Jeremy Raymond on 30/10/23.
//

import Foundation
import CoreData

struct Profile : Entity, Equatable {
    static func == (lhs: Profile, rhs: Profile) -> Bool {
        return lhs.daysAvailable == rhs.daysAvailable &&
        lhs.fitnessLevel == rhs.fitnessLevel &&
        lhs.timeOfDay == rhs.timeOfDay &&
        lhs.currentPregnancyWeek == rhs.currentPregnancyWeek &&
        lhs.preferredDuration == rhs.preferredDuration &&
        lhs.exceptions == rhs.exceptions
    }
    
    func intoNSObject(context: NSManagedObjectContext) -> NSManagedObject {
        let profilens = ProfileNSObject(context: context);
        
        profilens.name = self.name
        profilens.currentPregnancyWeek = Int16(self.currentPregnancyWeek)
        profilens.currentRelieveNeeded = self.currentRelieveNeeded.map{$0.rawValue}.joined(separator: ", ")
        profilens.daysAvailable = self.daysAvailable.map{$0.rawValue}.joined(separator: ", ")
        profilens.fitnessLevel = self.fitnessLevel.rawValue
        profilens.plan?.addingObjects(from: self.plan.map{$0.intoNSObject(context: context, parentProfileNSObject: profilens)})
        profilens.timeOfDay = self.timeOfDay.rawValue
        profilens.histories?.addingObjects(from: self.histories.map{
            $0.intoNSObject(context: context, parentProfileNS: profilens)})
        profilens.preferredDuration = self.preferredDuration.rawValue
        profilens.exceptions = self.exceptions.map{$0.rawValue}.joined(separator: ", ");
        
        return profilens
    }
    
    var name: String = ""
    var currentPregnancyWeek: Int = 0
    var currentRelieveNeeded: [Relieve] = []
    var fitnessLevel: Difficulty = .beginner
    var daysAvailable: [Day] = []
    var timeOfDay: TimeOfDay = .morning
    var preferredDuration: Duration = .tenMinutes
    var plan : [YogaPlan] = [] // Pasti 3
    var histories : [History] = []
    var exceptions : [Exception] = []
    
    var trimester: Trimester {
        if currentPregnancyWeek < 12 {
            return .first
        }
        else if currentPregnancyWeek > 24 {
            return .third
        }
        else {
            return .second
        }
    }
    
    var yogaPlan: YogaPlan {
        return plan.first(where: {$0.trimester == trimester}) ?? plan[0]
    }
    
    var yogas: [Yoga] {
        return yogaPlan.yogas
    }
    
    func getYogasByTrimester(trimester: Trimester) -> YogaPlan {
        switch trimester {
        case .first:
            return self.plan[0]
        case .second:
            return self.plan[1]
        case .third:
            return self.plan[2]
        case .all:
            return self.plan[3]
        }
    }
    
    func getCurrentYogaDay() {
        
    }
    
    
}
