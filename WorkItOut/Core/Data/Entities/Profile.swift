//
//  Profile.swift
//  WorkItOut
//
//  Created by Jeremy Raymond on 30/10/23.
//

import Foundation

struct Profile {
    var name: String = "Test Name"
    var currentWeek: Int = 10
    var currentRelieveNeeded: [Relieve] = []
    var fitnessLevel: Difficulty = .beginner
    var daysAvailable: [Day] = []
    var timeOfDay: TimeOfDay = .morning
    var preferredDuration: Duration = .fiveteenMinutes
    var plan : [YogaPlan] = [] // Pasti 3 =
    var histories : [History] = []
  
    func getCurrentYogaPlan() -> YogaPlan {
        return YogaPlan()
    }
//    func getCurrentYogaDay() -> Yoga {
//        return Yoga()
//    }
    func appendHistory() {
        
    }
}
