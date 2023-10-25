//
//  MockData.swift
//  CreateWorkoutPlan
//
//  Created by Jeremy Raymond on 23/10/23.
//

import Foundation

struct MockData {
    static var mockWorkoutPlan: WorkoutPlan = WorkoutPlan()
    static var mockWorkout: Workout = Workout(exercises: [], workoutState: .onProgress, date: Date.now)
    
    static var mockExercises: [Exercise] = [
        Exercise(
            name: "Triceps Extension",
            muscleGroup: [.arm],
            equipment: [.noEquipment],
            repetition: 20,
            workoutSet: 2
        ),
        Exercise(
            name: "Dips",
            muscleGroup: [.arm],
            equipment: [.dipbar],
            repetition: 12,
            workoutSet: 4
        ),
        Exercise(
            name: "Dumbbell Curls",
            muscleGroup: [.arm],
            equipment: [.dumbbell],
            repetition: 10,
            workoutSet: 2
        ),
        Exercise(
            name: "Squats",
            muscleGroup: [.leg],
            equipment: [.noEquipment],
            repetition: 10,
            workoutSet: 3
        ),
        Exercise(
            name: "Lunge",
            muscleGroup: [.leg],
            equipment: [.noEquipment],
            repetition: 12,
            workoutSet: 3
        ),
        Exercise(
            name: "Pushups",
            muscleGroup: [.chest],
            equipment: [.noEquipment],
            repetition: 5,
            workoutSet: 3
        ),
        Exercise(
            name: "Bench Press",
            muscleGroup: [.chest],
            equipment: [.dumbbell],
            repetition: 10,
            workoutSet: 3
        ),
        Exercise(
            name: "Plank",
            muscleGroup: [.chest],
            equipment: [.noEquipment],
            repetition: 15,
            workoutSet: 3
        ),
        Exercise(
            name: "Situps",
            muscleGroup: [.chest],
            equipment: [.noEquipment],
            repetition: 20,
            workoutSet: 3
        ),
        Exercise(
            name: "Crunchs",
            muscleGroup: [.chest],
            equipment: [.noEquipment],
            repetition: 20,
            workoutSet: 4
        ),
        Exercise(
            name: "Pullups",
            muscleGroup: [.back],
            equipment: [.pullupbar],
            repetition: 10,
            workoutSet: 2
        ),
        Exercise(
            name: "Deadlifts",
            muscleGroup: [.back],
            equipment: [.dumbbell],
            repetition: 5,
            workoutSet: 3
        ),
    ]
}
