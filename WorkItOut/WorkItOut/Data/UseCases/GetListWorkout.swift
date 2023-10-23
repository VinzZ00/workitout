//
//  getListWorkout.swift
//  WorkItOut
//
//  Created by Elvin Sestomi on 21/10/23.
//

import Foundation

struct GetWorkoutList {
    let db = FireStoreManager();
    
    
    func call() async -> [RequestExercise] {
        
        var exercisesReq : [RequestExercise] = []
        
        await db.getCollection(collectionName: FirebaseConstant.ExerciseCollectionConstants.collectionName) { querrySnapShot in
            querrySnapShot.documents.forEach { doc in
                
                let exerciseName = doc.data()[FirebaseConstant.ExerciseCollectionConstants.name] as! String
                let exerciseMuscleGroup = (doc.data()[FirebaseConstant.ExerciseCollectionConstants.muscleGroup] as! String).split(separator: ", ") as! [String]
                let exerciseEquipment = (doc.data()[FirebaseConstant.ExerciseCollectionConstants.equipment] as! String).split(separator: ", ") as! [String]
                let weight = (doc.data()[FirebaseConstant.ExerciseCollectionConstants.weight] as? Double ?? 0.0)
                
                exercisesReq.append(RequestExercise(name: exerciseName, muscleGroup: exerciseMuscleGroup, equipment: exerciseEquipment))

            }
        }
        
        return exercisesReq;
    }
}
