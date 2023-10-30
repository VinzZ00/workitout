//
//  helper.swift
//  WorkItOut
//
//  Created by Elvin Sestomi on 30/10/23.
//

import Foundation
import CoreData

protocol Entity {
    func intoNSObject(context : NSManagedObjectContext) -> NSManagedObject;
}
