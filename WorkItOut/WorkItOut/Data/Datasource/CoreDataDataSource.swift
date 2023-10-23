//
//  CoreDataDataSource.swift
//  WorkItOut
//
//  Created by Elvin Sestomi on 23/10/23.
//

import Foundation
import SwiftUI
import CoreData

struct CoreDataDataSource : coreDataDataSourceDelegate {
    
    func fetchFromCoreData(context: NSManagedObjectContext, entity : NSManagedObject.Type) async throws -> Result<[NSFetchRequestResult], Error> {
        var fetchRequest = entity.fetchRequest()
        
        do {
            return try .success(context.fetch(fetchRequest))
        } catch let err {
            return .failure(err)
        }
        
    }
    
    func saveToCoreData(workout : Workout, context : NSManagedObjectContext) async throws {
        
        let workoutRec = WorkoutNSObject(context: context);
        workoutRec.workoutState = workout.workoutState == .finished ? true : false
        workoutRec.exercises = NSSet(array: workout.exercises)
        
        do {
            try context.save()
        } catch let err {
            throw err;
        }
    }
    
    func updateToCoreData(workout : Workout, context : NSManagedObjectContext) async throws {
        let workoutRec = WorkoutNSObject(context: context)
        workoutRec.workoutState = workout.workoutState == .finished ? true : false
        workoutRec.exercises = NSSet(array: workout.exercises)
        
        do {
            try context.save()
        } catch let err {
            throw err;
        }
    }
    
    

}
