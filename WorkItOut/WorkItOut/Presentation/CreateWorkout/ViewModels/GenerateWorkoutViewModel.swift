//
//  GenerateWorkoutViewModel.swift
//  CreateWorkoutPlan
//
//  Created by Jeremy Raymond on 23/10/23.
//

import Foundation

class GenerateWorkoutViewModel: ObservableObject {
    @Published var workoutPlan: WorkoutPlan = MockData.mockWorkoutPlan
    @Published var workoutWeekday: [Day : Workout] = [:]

    init() {
        refreshWorkoutPlan()
    }
    
    func refreshWorkoutPlan() {
        workoutPlan = MockData.mockWorkoutPlan
        if !workoutsEmpty() {
            generateWeeklyWorkout()
        }
        
    }
    
    func workoutsEmpty() -> Bool {
        if workoutPlan.workouts.isEmpty {
            return true
        }
        return false
    }
    
    func changeExercise(day: Day, exercise: Exercise, newExercise: Exercise) {
        let index = self.workoutWeekday[day]!.exercises.firstIndex(of: exercise)!
        self.workoutWeekday[day]!.exercises.modifyElement(atIndex: index) {
            $0 = newExercise
        }
    }
    
    func generateWeeklyWorkout() {
        for day in Day.allCases {
            for workout in workoutPlan.workouts {
                if Calendar.current.isDate(day.getWeekday(), equalTo: workout.date, toGranularity: .day){
                    print("match")
                    self.workoutWeekday.updateValue(workout, forKey: day)
                }
            }
           
        }
    }
}


