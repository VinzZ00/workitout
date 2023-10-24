//
//  Workout.swift
//  WorkItOut
//
//  Created by Elvin Sestomi on 21/10/23.
//

import Foundation

//enum WorkoutState {
//    case onProgress
//    case finished
//}

struct Workout: Identifiable, Hashable {
    var id: UUID = UUID()
    var exercises : [Exercise] = []
    var workoutState : WorkoutState = .onProgress
    var date : Date = Date.now
    
    func getDesiredDate(desired : Set<Calendar.Component>) -> DateComponents {
        return Calendar.current.dateComponents(desired, from: self.date)
    }
    
    static func == (lhs: Workout, rhs: Workout) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

}

//Workout().getDesiredDate(desired: [.])
