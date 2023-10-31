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
        profilens.plan?.addingObjects(from: self.plan.map{$0.ofProfile = profilens})
        profilens.timeOfDay = self.timeOfDay.rawValue
        
        //TODO: MASUKIN HISTORY
        
        profilens.preferredDuration = self.preferredDuration.rawValue
        
        return profilens
    }
    
    var name: String
    var currentPregnancyWeek: Int
    var currentRelieveNeeded: [Relieve]
    var fitnessLevel: Difficulty
    var daysAvailable: [Day]
    var timeOfDay: TimeOfDay
    var preferredDuration: Duration
    var plan : [YogaPlanNSObject] // Pasti 3
    var histories : [HistoryNSObject]
    
    func getCurrentYogaPlan() -> YogaPlan {
        return YogaPlan()
    }
    
    func getCurrentYogaDay() {
        
    }
    
    func appendHistory() {
        
    }
    
    
}
