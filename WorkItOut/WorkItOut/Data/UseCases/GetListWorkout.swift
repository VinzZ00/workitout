//
//  getListWorkout.swift
//  WorkItOut
//
//  Created by Elvin Sestomi on 21/10/23.
//

import Foundation

struct GetWorkoutList {
    private init() {}
    let db = FireStoreManager();
    
    
    func call() -> [String] {
        
        var exercisesName : [String] = []
        
        db.getCollection(collectionName: FirebaseConstant.ExerciseCollectionConstants.collectionName) { querrySnapShot in
            querrySnapShot.documents.forEach { doc in
                
                var exerciseName = doc.data()[FirebaseConstant.ExerciseCollectionConstants.name] as! String
                
                exercisesName.append(exerciseName)

            }
        }
        
        return exercisesName;
    }
}
