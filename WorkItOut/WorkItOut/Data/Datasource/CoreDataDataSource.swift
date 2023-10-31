//
//  CoreDataDataSource.swift
//  WorkItOut
//
//  Created by Elvin Sestomi on 23/10/23.
//

import Foundation
import SwiftUI
import CoreData

struct CoreDataDataSource : CoreDataDataSourceDelegate {
    
    func fetchFromCoreData(context: NSManagedObjectContext, entity : NSManagedObject.Type) async throws -> Result<[NSFetchRequestResult], Error> {
        let fetchRequest = entity.fetchRequest()
        
        do {
            return try .success(context.fetch(fetchRequest))
        } catch let err {
            return .failure(err)
        }
        
    }
    
    func saveToCoreData(context : NSManagedObjectContext) async throws {
        do {
            try context.save()
        } catch let err {
            throw err;
        }
    }
    
    func updateToCoreData<T : Entity>(entity : T, context : NSManagedObjectContext) async throws {

        var entity = entity.intoNSObject(context: context)
        
        do {
            try context.save()
        } catch let err {
            throw err;
        }
    }
}

//var ygpl = YogaPlan()
//
//@Environment(\.managedObjectContext) var moc : NSManagedObjectContext
//
//ygpl.yogas.first?.poses.first?.name = "yoga pose 1";
//
//UpdateYogaPlanUsecase().call(yogaPlan: ygpl, context: moc)




