//
//  Profile.swift
//  WorkItOut
//
//  Created by Jeremy Raymond on 30/10/23.
//

import Foundation

struct Profile {
    var name: String
    var currentWeek: Date
    var currentRelieveNeeded: [Relieve]
    var fitnessLevel: Difficulty
    var daysAvailable: [Day]
    var timeOfDay: TimeOfDay
    var preferredDuration: Duration
      var plan : [YogaPlan] // Pasti 3
      var histories : [History]
  
    func getCurrentYogaPlan() -> YogaPlan {
        return YogaPlan()
    }
//    func getCurrentYogaDay() -> Yoga {
//        return Yoga()
//    }
    func appendHistory() {
        
    }
}
