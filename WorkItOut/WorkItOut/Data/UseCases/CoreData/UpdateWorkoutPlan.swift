//
//  UpdateWorkoutUseCase.swift
//  WorkItOut
//
//  Created by Elvin Sestomi on 23/10/23.
//

import Foundation
import CoreData

struct UpdateWorkoutUseCase {
    var repository = Repository()
    
    func call(yogaPlan : YogaPlan, context : NSManagedObjectContext) async {
        do {
            try await repository.coreData.updateToCoreData(entity: yogaPlan, context: context)
        } catch let err {
            fatalError("Error update workout: \(err.localizedDescription)")
        }
    }
}
