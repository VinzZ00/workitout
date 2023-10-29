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

struct Yoga: Identifiable, Hashable {
    let id: UUID = UUID()
    var poses : [Pose]
    var date : Date
    var estimationDuration : DateInterval
    var yogaState : YogaState
    
    func getDesiredDate(desired : Set<Calendar.Component>) -> DateComponents {
        return Calendar.current.dateComponents(desired, from: self.date)
    }
    
    static func == (lhs: Yoga, rhs: Yoga) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

}

//Workout().getDesiredDate(desired: [.])
