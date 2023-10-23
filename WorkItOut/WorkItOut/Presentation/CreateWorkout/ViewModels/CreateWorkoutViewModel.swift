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
        let workout = Workout()
        for day in days {
            for muscle in muscleGroups {
                workout.exercises.append(
                    MockData.mockExercises.filter({ $0.muscleGroup.contains(muscle)}).randomElement()!
                )
                workout.exercises[workout.exercises.endIndex-1].day = day
            }
        }
        
        MockData.mockWorkout = workout
    }
}
