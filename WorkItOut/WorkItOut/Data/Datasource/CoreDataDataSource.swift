//
//  CoreDataDataSource.swift
//  WorkItOut
//
//  Created by Elvin Sestomi on 23/10/23.
//

import Foundation
import SwiftUI
import CoreData

protocol CoreDataDataSourceDelegate {
    func saveToCoreData<T : NSManagedObject>(entity : T, context : NSManagedObjectContext) async throws
    func updateToCoreData<T : NSManagedObject> (entity : T, context : NSManagedObjectContext) async throws
    func fetchFromCoreData(context : NSManagedObjectContext, entity : NSManagedObject.Type) async throws -> Result<[NSFetchRequestResult], Error>
}

struct CoreDataDataSource : CoreDataDataSourceDelegate {
    
    func fetchFromCoreData(context: NSManagedObjectContext, entity : NSManagedObject.Type) async throws -> Result<[NSFetchRequestResult], Error> {
        let fetchRequest = entity.fetchRequest()
        
        do {
            return try .success(context.fetch(fetchRequest))
        } catch let err {
            return .failure(err)
        }
        
    }
    
    func saveToCoreData<T : NSManagedObject>(entity : T, context : NSManagedObjectContext) async throws {
        
        do {
            try context.save()
        } catch let err {
            throw err;
        }
    }
    
    func updateToCoreData<T : NSManagedObject>(entity : T, context : NSManagedObjectContext) async throws {
        
        do {
            try context.save()
        } catch let err {
            throw err;
        }
    }
}




