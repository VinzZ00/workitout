//
//  GenerateWorkoutViewModel.swift
//  CreateWorkoutPlan
//
//  Created by Jeremy Raymond on 23/10/23.
//

import Foundation

class GenerateWorkoutViewModel: ObservableObject {
    @Published var workout: Workout = MockData.mockWorkout

    init() {
        refreshWorkout()
    }
    
    func refreshWorkout() {
        workout = MockData.mockWorkout
    }
}
