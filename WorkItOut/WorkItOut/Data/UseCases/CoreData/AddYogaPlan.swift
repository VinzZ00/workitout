//
//  addWorkouts.swift
//  WorkItOut
//
//  Created by Elvin Sestomi on 23/10/23.
//

import Foundation
import CoreData

struct AddYogaPlanUsecase {
    var repository : Repository = Repository()
    
    func call(yogaPlan : YogaPlan, context : NSManagedObjectContext) async {
        
        var yogaPlanNS = yogaPlan.intoNSObject(context: context);
        
        do {
            try await repository.coreData.saveToCoreData(context: context)
        } catch let err{
            fatalError("Failed to save to coredata: \(err.localizedDescription)")
        }
    }
}
