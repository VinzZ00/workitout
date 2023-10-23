//
//  CoreDataDataSource.swift
//  WorkItOut
//
//  Created by Elvin Sestomi on 23/10/23.
//

import Foundation
import CoreData

struct CoreDataDataSource {
    func saveToCoreData(workout : Workout, context : NSManagedObjectContext) async throws {
        let workoutRec = WorkoutNSObject(context: context);
        workoutRec.workoutState = false
        workoutRec.exercises = NSSet(array: workout.exercises)
        
        do {
            try context.save()
        } catch let err {
            throw err;
        }
    }
    
//    func updateToCoreData(workout : Workout, context : NSManagedObjectContext) {
//        let workoutRec = WorkoutNSObject(context: context)
//        workoutRec.workoutState = workout
//    }
//    
//    func fetchWorkoutData() -> workout
}
