//
//  History.swift
//  WorkItOut
//
//  Created by Jeremy Raymond on 30/10/23.
//

import Foundation
import CoreData

struct History : Entity, Identifiable, Equatable {
    func intoNSObject(context: NSManagedObjectContext, parentProfileNS : ProfileNSObject) -> NSManagedObject {
        let historyNS = HistoryNSObject(context: context)
        historyNS.uuid = self.id;
        historyNS.executionDate = self.executionDate
        historyNS.rating = Int16(self.rating)
        historyNS.duration = Int32(self.duration)
        historyNS.ofProfile = parentProfileNS
        // MARK: YANG DITAMBAHKAN UNTUK MENGANTIKAN VERSI SEBELUMNYA YANG ARRAY
        historyNS.yogaDone = self.yogaDone.intoNSObject(context: context, parentHistoryNS: historyNS) as? YogaNSObject
        return historyNS;
    }
    
    static func == (lhs : History, rhs : History) -> Bool {
        return lhs.id == rhs.id
    }
    
    var id : UUID
    var yogaDone : Yoga
    var executionDate : Date
    var duration : Int
    var rating : Int
    
    
}
