//
//  ExecutionViewModel.swift
//  WorkItOut
//
//  Created by Angela Valentine Darmawan on 25/10/23.
//

import Foundation

class ExecutionViewModel: ObservableObject {
    var workoutPlan: WorkoutPlan = MockData.mockWorkoutPlan
    @Published var workoutToday: [Workout] = []
    @Published var index = -1
//    var exercise: Exercise
    
//    func callWorkout() -> {
//        index += 1
//        return workoutToday.exercise[index]
//    }
    
    func getWorkout(){
        for workout in workoutPlan.workouts {
            if Calendar.current.isDate(Date(), equalTo: workout.date, toGranularity: .weekday) {
                self.workoutToday.append(workout)
            }
        }
    }
}
