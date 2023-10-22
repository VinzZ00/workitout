//
//  CoreDataManager.swift
//  WorkItOut
//
//  Created by Elvin Sestomi on 22/10/23.
//

import Foundation
import CoreData

class CoreDataManager : ObservableObject {
    let container : NSPersistentContainer = NSPersistentContainer(name: "PersistentStorage")
    
    init() {
        container.loadPersistentStores { desc, err in
            if err != nil {
                fatalError("Error Loading CoreData : \(err?.localizedDescription ?? "Error tidak diketahui")")
            }
            print("Core Data Successfully Loaded")
        }
    }
}
