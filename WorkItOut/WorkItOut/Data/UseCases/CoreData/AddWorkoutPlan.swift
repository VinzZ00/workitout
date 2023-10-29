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
    
    func call(yogaPlan : YogaPlan, context : NSManagedObjectContext) async {
        
        let nsWorkoutPlan = WorkoutPlanNSObject(context: context)
        nsWorkoutPlan.workouts = NSSet(array: yogaPlan.yogas)
        
        
        do {
            try await repository.coreData.saveToCoreData(entity: nsWorkoutPlan, context: context)
        } catch let err{
            fatalError("Failed to save to coredata: \(err.localizedDescription)")
        }
    }
}
