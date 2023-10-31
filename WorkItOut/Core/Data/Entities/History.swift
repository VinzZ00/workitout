//
//  History.swift
//  WorkItOut
//
//  Created by Jeremy Raymond on 30/10/23.
//

import Foundation
import CoreData

struct History : Entity {
    func intoNSObject(context: NSManagedObjectContext) -> NSManagedObject {
        let historyNS = HistoryNSObject(context: context)
        historyNS.id = UUID();
        historyNS.executionDate = self.executionDate
        historyNS.rating = Int16(self.rating)
        historyNS.duration = Int32(self.duration)
        historyNS.yogaDone?.addingObjects(from: self.yogaDone.map{$0.ofHistory = historyNS})
        
        return historyNS;
    }
    
    
    var yogaDone : [YogaNSObject]
    var executionDate : Date
    var duration : Int
    var rating : Int
    
    
}
