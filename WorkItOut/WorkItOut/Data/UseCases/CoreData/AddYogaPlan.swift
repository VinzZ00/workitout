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
        
        let nsWorkoutPlan = yogaPlan
        
        do {
            try await repository.coreData.saveToCoreData(entity: yogaPlan.intoNSObject(context: context), context: context)
        } catch let err{
            fatalError("Failed to save to coredata: \(err.localizedDescription)")
        }
    }
}
