//
//  UpdateWorkoutUseCase.swift
//  WorkItOut
//
//  Created by Elvin Sestomi on 23/10/23.
//

import Foundation
import CoreData

struct UpdateProfileUseCase {
    var repository = Repository()
    
    func call(profile : Profile, context : NSManagedObjectContext) async {
        do {
            try await repository.coreData.updateToCoreData(entity: profile.intoNSObject(context: context), context: context)
        } catch let err {
            fatalError("Error update workout: \(err.localizedDescription)")
        }
    }
}
