//
//  Workout.swift
//  WorkItOut
//
//  Created by Elvin Sestomi on 21/10/23.
//

import Foundation

enum WorkoutState {
    case onProgress
    case finished
}

struct Workout {
    var exercises : [Exercise]
    var workoutState : WorkoutState
    var date : Date
    
    func getDesiredDate(desired : Set<Calendar.Component>) -> DateComponents {
        return Calendar.current.dateComponents(desired, from: self.date)
    }
}
