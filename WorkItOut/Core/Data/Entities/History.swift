//
//  History.swift
//  WorkItOut
//
//  Created by Jeremy Raymond on 30/10/23.
//

import Foundation
import CoreData

struct History : Entity, Identifiable {
    func intoNSObject(context: NSManagedObjectContext, parentProfileNS : ProfileNSObject) -> NSManagedObject {
        let historyNS = HistoryNSObject(context: context)
        historyNS.uuid = self.id;
        historyNS.executionDate = self.executionDate
        historyNS.rating = Int16(self.rating)
        historyNS.duration = Int32(self.duration)
        historyNS.yogaDone?.addingObjects(from: self.yogaDone.map{$0.intoNSObject(context: context, parentHistoryNS: historyNS)})
        historyNS.ofProfile = parentProfileNS
        return historyNS;
    }
    
    var id : UUID
    var yogaDone : [Yoga]
    var executionDate : Date
    var duration : Int
    var rating : Int
    
    
}
