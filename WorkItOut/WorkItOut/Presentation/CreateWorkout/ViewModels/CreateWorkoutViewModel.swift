//
//  CreateWorkoutViewModel.swift
//  CreateWorkoutPlan
//
//  Created by Jeremy Raymond on 23/10/23.
//

import Foundation



class CreateWorkoutViewModel: ObservableObject {
    @Published var height: Double = 0
    @Published var weight: Double = 0
    @Published var days: [Day] = [.tuesday, .friday]
    @Published var muscleGroups: [MuscleGroup] = [.abs, .back]
    @Published var hasEquipment: Bool = false
    @Published var needReminder: Bool = false
    
    func checkMuscleGroup(muscleGroup: MuscleGroup) -> Bool {
        if self.muscleGroups.firstIndex(of: muscleGroup) == nil {
            return false
        }
        return true
    }
    
    func addMuscleGroup(muscleGroup: MuscleGroup) {
        self.muscleGroups.append(muscleGroup)
    }
    
    func removeMuscleGroup(muscleGroup: MuscleGroup) {
        let index = self.muscleGroups.firstIndex(of: muscleGroup)!
        self.muscleGroups.remove(at: index)
    }
    
    func checkDay(day: Day) -> Bool {
        if self.days.firstIndex(of: day) == nil {
            return false
        }
        return true
    }
    
    func addDay(day: Day) {
        self.days.append(day)
    }
    
    func removeDay(day: Day) {
        let index = self.days.firstIndex(of: day)!
        self.days.remove(at: index)
    }
    
    func createWorkout() {
        var workoutPlan = WorkoutPlan()
        for day in days {
            var workout = Workout()
            for muscle in muscleGroups {
                workout.exercises.append(
                    MockData.mockExercises.filter({ $0.muscleGroup.contains(muscle)}).randomElement()!
                )
//                workout.date = Workout.getDesiredDate(desired: )
//                workout.exercises[workout.exercises.endIndex-1] = day
            }
            workout.date = getWeekday(day: day)
            
            workoutPlan.workouts.append(workout)
        }
        MockData.mockWorkoutPlan = workoutPlan
//        MockData.mockWorkout = workout
    }
    
    func getWeekday(day: Day) -> Date {
        let today = Date()
        let calendar = Calendar.current
        let dayOfWeek = calendar.component(.weekday, from: today)
        
//         Adjust the day to make Sunday the first day of the week (if needed)
//        let adjustedDayOfWeek = (dayOfWeek - calendar.firstWeekday + 7) % 7
        let adjustedDayOfWeek = (dayOfWeek - calendar.firstWeekday + day.rawValue) % 7

        
        let adjustedDate = calendar.date(byAdding: .day, value: adjustedDayOfWeek, to: today)
        
        print(adjustedDate!, "Test")
        return adjustedDate ?? Date.now
        
//        return (adjustedDayOfWeek + day.rawValue)
    }
    
//    func getWeekday(day: Day) -> Date {
//        let currentDate = Date()
//                
//        // Create a Calendar instance
//        let calendar = Calendar.current
//        
//        // Get the current weekday (1 = Sunday, 2 = Monday, ..., 7 = Saturday)
//        let currentWeekday = calendar.component(.weekday, from: currentDate)
//        
//        // Calculate the number of days to add to reach Tuesday (assuming Sunday is the first day)
//        let daysToAdd = 2 - currentWeekday + 7
//        
//        // Calculate the date for the next Tuesday
//        let nextTuesday = calendar.date(byAdding: .day, value: daysToAdd, to: currentDate)
//        
//        return nextTuesday!
//    }
}
