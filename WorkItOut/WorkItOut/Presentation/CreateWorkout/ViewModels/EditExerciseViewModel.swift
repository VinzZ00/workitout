//
//  EditExerciseViewModel.swift
//  WorkItOut
//
//  Created by Jeremy Raymond on 24/10/23.
//

import Foundation

class EditExerciseViewModel: ObservableObject {
    @Published var day: Day
    @Published var exercise: Exercise

    @Published var exercisePicker: Exercise = MockData.mockExercises.randomElement()!
    @Published var reps: Double = 1
    @Published var sets: Double = 1
    
    init(day: Day, exercise: Exercise) {
        self.day = day
        self.exercise = exercise
    }
}
