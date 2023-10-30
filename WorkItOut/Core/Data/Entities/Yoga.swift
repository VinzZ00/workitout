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
    var poses : [Pose] = []
    var date : Day = .monday
    var estimationDuration : DateInterval {
        return DateInterval()
    }
    var yogaState : YogaState = .notCompleted
    var image: String?
    
    static func == (lhs: Yoga, rhs: Yoga) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

}

//Workout().getDesiredDate(desired: [.])
