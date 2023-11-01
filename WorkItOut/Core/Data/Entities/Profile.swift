//
//  Profile.swift
//  WorkItOut
//
//  Created by Jeremy Raymond on 30/10/23.
//

import Foundation
import CoreData

struct Profile : Entity {
    func intoNSObject(context: NSManagedObjectContext) -> NSManagedObject {
        var profilens = ProfileNSObject(context: context);
        
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
        
        return profilens
    }
    
    var name: String = ""
    var currentPregnancyWeek: Int = 0
    var currentRelieveNeeded: [Relieve] = []
    var fitnessLevel: Difficulty = .beginner
    var daysAvailable: [Day] = []
    var timeOfDay: TimeOfDay = .morning
    var preferredDuration: Duration = .fiveteenMinutes
    var plan : [YogaPlan] = [] // Pasti 3
    var histories : [History] = []
    
//    func getCurrentYogaPlan() -> YogaPlan {
//        return self.plan
//    }
    
    func getCurrentYogaDay() {
        
    }
    
    func appendHistory() {
        
    }
    
    
}
