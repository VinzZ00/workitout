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
    
    struct ExerciseCollectionConstants {
        static let collectionName = "Exercise"
        static let name = "name"
        static let muscleGroup = "muscleGroup"
        static let equipment = "equipment"
        static let weight = "weight"
        
        private init() {}
    }
    
    struct YogaPoseConstants {
        static let collectionName = "Yoga"
        static let name = "yogaPose"
        static let altName = "altName"
        static let category = "category"
        static let difficulty = "difficulty"
        static let exceptions = "exceptions"
        static let recommendedTrimester = "recommendedTrimester"
        static let relieves = "relieves"
        static let status = "status"
        static let videoURL = "videoUrl"
        static let imageURL = "imageUrl"
        
//        Deprecated
//        static let bodyPartTrained = "bodyPartTrained"
//        static let position = "position"
//        static let spineMovement = "spineMovement"
    }
}

