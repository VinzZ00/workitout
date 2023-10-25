//
//  WorkoutPlan.swift
//  WorkItOut
//
//  Created by Jeremy Raymond on 23/10/23.
//

import Foundation

struct WorkoutPlan : Identifiable {
    var id: UUID = UUID()
    var workouts: [Workout] = []
}
