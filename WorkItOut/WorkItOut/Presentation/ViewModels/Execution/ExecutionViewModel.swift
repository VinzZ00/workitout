//
//  ExecutionViewModel.swift
//  WorkItOut
//
//  Created by Angela Valentine Darmawan on 25/10/23.
//

import Foundation

class ExecutionViewModel: ObservableObject {
    @Published var workoutPlan: WorkoutPlan = MockData.mockWorkoutPlan
    @Published var workoutWeekday: [Day : Workout] = [:]
    @Published var workoutToday = Workout()
    @Published var index = -1
    @Published var exercise = ""
//    @Published var day
//    var exercise: Exercise
    
//    init() {
//        getWorkout()
//    }
//
    func callWorkout(var idx: Int)  {
        var exercises = workoutToday.exercises[idx]
//        for i in 0...workoutToday.exercises.count {
//            exercise = workoutToday.exercises[i].name
//        }
    }
    
    func getWorkout(workoutWeekday: [Day : Workout]){
        var day = Date()
        for workout in workoutPlan.workouts {
            if Calendar.current.isDate(day, equalTo: workout.date, toGranularity: .day){
                self.workoutToday = workout
                break
            }
        }
        
//        for day in Day.allCases {
//            for workout in workoutPlan.workouts {
//                if Calendar.current.isDate(day.getWeekday(), equalTo: workout.date, toGranularity: .day){
//                    print("match")
//                    self.workoutWeekday.updateValue(workout, forKey: day)
//                }
//            }
//
//        }
    }
}
