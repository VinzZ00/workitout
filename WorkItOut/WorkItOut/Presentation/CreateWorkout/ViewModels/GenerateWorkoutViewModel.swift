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
                if Calendar.current.isDate(getWeekday(day: day), equalTo: workout.date, toGranularity: .day){
                    print("match")
                    self.workoutWeekday.updateValue(workout, forKey: day)
                }
            }
           
        }
    }
    
    func getWeekday(day: Day) -> Date {
        let today = Date()
        let calendar = Calendar.current
        let dayOfWeek = calendar.component(.weekday, from: today)
        
        let adjustedDayOfWeek = (dayOfWeek - calendar.firstWeekday + day.rawValue) % 7
        
        let adjustedDate = calendar.date(byAdding: .day, value: adjustedDayOfWeek, to: today)
        
        return adjustedDate ?? Date.now
    }
}

extension Array {
    mutating func modifyForEach(_ body: (_ index: Index, _ element: inout Element) -> ()) {
        for index in indices {
            modifyElement(atIndex: index) { body(index, &$0) }
        }
    }

    mutating func modifyElement(atIndex index: Index, _ modifyElement: (_ element: inout Element) -> ()) {
        var element = self[index]
        modifyElement(&element)
        self[index] = element
    }
}
