//
//  FirebaseConstant.swift
//  WorkItOut
//
//  Created by Elvin Sestomi on 21/10/23.
//

import Foundation

struct FirebaseConstant {
    private init() {}
}

extension FirebaseConstant {
    struct WorkoutCollectionConstants {
        static let collectionName = "Workout"
        static let exercise = "exercise"
        static let workoutState = "workoutState"
        
        private init() {}
    }
    
    struct ExerciseCollectionConstants {
        static let collectionName = "Exercise"
        static let name = "name"
        static let muscleGroup = "muscleGroup"
        static let equipment = "equipment"
        static let weight = "weight"
        static let repetition = "repetition"
        static let workoutSet = "workoutSet"
        static let date = "date"
        
        private init() {}
    }
}

