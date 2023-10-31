//
//  CoreDataDataSourceDelegate.swift
//  WorkItOut
//
//  Created by Elvin Sestomi on 23/10/23.
//

import Foundation
import CoreData

protocol CoreDataDataSourceDelegate {
    func saveToCoreData(context : NSManagedObjectContext) async throws
    func updateToCoreData<T : Entity> (entity : T, context : NSManagedObjectContext) async throws
    func fetchFromCoreData(context : NSManagedObjectContext, entity : NSManagedObject.Type) async throws -> Result<[NSFetchRequestResult], Error>
}
