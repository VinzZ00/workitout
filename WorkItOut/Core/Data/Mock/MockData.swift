//
//  MockData.swift
//  CreateWorkoutPlan
//
//  Created by Jeremy Raymond on 23/10/23.
//

import Foundation

struct MockData {
//    static var mockWorkoutPlan: YogaPlan = YogaPlan()
//    static var mockWorkout: Yoga = Yoga(exercises: [], workoutState: .onProgress, date: Date.now)
    
    static var yogas =
        Yoga(id: UUID(), name: "Yoga 1", poses: [
            Pose(id: UUID(), name: "Pose1", difficulty: .beginner, exception: [.vertigo], recommendedTrimester: .all, relieve: [.back], description: "Desc 1", seconds: 12, state: .completed),
            Pose(id: UUID(), name: "Pose2", difficulty: .beginner, exception: [.vertigo], recommendedTrimester: .all, relieve: [.back], description: "Desc 1", seconds: 12, state: .completed),
            Pose(id: UUID(), name: "Pose3", difficulty: .beginner, exception: [.vertigo], recommendedTrimester: .all, relieve: [.back], description: "Desc 1", seconds: 12, state: .completed)
        ], day: .friday, estimationDuration: 12, image: "Image 1")
    
    
    static var mockProfile: Profile {
        var profile =
        Profile(
            name: "Testing add and fetch",
            currentPregnancyWeek: 2,
            currentRelieveNeeded: [.back, .hip],
            fitnessLevel: .beginner,
            daysAvailable: [.monday, .wednesday, .friday],
            timeOfDay: .evening,
            preferredDuration: .thirtyMinutes,
            plan: [
                YogaPlan(id: UUID(), name: "Plan 1", trimester: .first)
            ],
            histories: [])
        
        profile.plan[0].yogas.append(yogas);
        return profile;
    }
//    static var mockExercises: [Pose] = [
//        Pose(
//            name: "Triceps Extension",
//            muscleGroup: [.arm],
//            equipment: [.noEquipment],
//            repetition: 20,
//            workoutSet: 2
//        ),
//        Pose(
//            name: "Dips",
//            muscleGroup: [.arm],
//            equipment: [.dipbar],
//            repetition: 12,
//            workoutSet: 4
//        ),
//        Pose(
//            name: "Dumbbell Curls",
//            muscleGroup: [.arm],
//            equipment: [.dumbbell],
//            repetition: 10,
//            workoutSet: 2
//        ),
//        Pose(
//            name: "Squats",
//            muscleGroup: [.leg],
//            equipment: [.noEquipment],
//            repetition: 10,
//            workoutSet: 3
//        ),
//        Pose(
//            name: "Lunge",
//            muscleGroup: [.leg],
//            equipment: [.noEquipment],
//            repetition: 12,
//            workoutSet: 3
//        ),
//        Pose(
//            name: "Pushups",
//            muscleGroup: [.chest],
//            equipment: [.noEquipment],
//            repetition: 5,
//            workoutSet: 3
//        ),
//        Pose(
//            name: "Bench Press",
//            muscleGroup: [.chest],
//            equipment: [.dumbbell],
//            repetition: 10,
//            workoutSet: 3
//        ),
//        Pose(
//            name: "Plank",
//            muscleGroup: [.chest],
//            equipment: [.noEquipment],
//            repetition: 15,
//            workoutSet: 3
//        ),
//        Pose(
//            name: "Situps",
//            muscleGroup: [.chest],
//            equipment: [.noEquipment],
//            repetition: 20,
//            workoutSet: 3
//        ),
//        Pose(
//            name: "Crunchs",
//            muscleGroup: [.chest],
//            equipment: [.noEquipment],
//            repetition: 20,
//            workoutSet: 4
//        ),
//        Pose(
//            name: "Pullups",
//            muscleGroup: [.back],
//            equipment: [.pullupbar],
//            repetition: 10,
//            workoutSet: 2
//        ),
//        Pose(
//            name: "Deadlifts",
//            muscleGroup: [.back],
//            equipment: [.dumbbell],
//            repetition: 5,
//            workoutSet: 3
//        ),
//    ]
}
