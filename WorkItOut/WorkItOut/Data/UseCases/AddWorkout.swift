//
//  addWorkouts.swift
//  WorkItOut
//
//  Created by Elvin Sestomi on 23/10/23.
//

import Foundation
import CoreData

struct AddWorkoutUseCase {
    var repository : Repository = Repository()
    
    func call(workout : Workout, context : NSManagedObjectContext) async {
        do {
            try await repository.coreData.saveToCoreData(workout: workout, context: context)
        } catch let err{
            fatalError("Failed to save to coredata: \(err.localizedDescription)")
        }
    }
}
