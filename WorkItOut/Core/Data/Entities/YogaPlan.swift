//
//  WorkoutPlan.swift
//  WorkItOut
//
//  Created by Jeremy Raymond on 23/10/23.
//

import Foundation
import CoreData

struct YogaPlan : Identifiable {
    var id: UUID = UUID()
    var name: String = ""
    var yogas: [Yoga] = []
    var trimester: Trimester = .all
//    
//    init(id: UUID, name: String, yogas: [Yoga], trimester: Trimester) {
//        self.id = id
//        self.name = name
//        self.yogas = yogas
//        self.trimester = trimester
//    }
    
    func intoNSObject(context : NSManagedObjectContext) -> NSManagedObject{
        let yogaPlan = YogaPlanNSObject(context: context)
        yogaPlan.uuid = UUID()
        yogaPlan.name = self.name
        yogaPlan.yogas = NSSet(array: self.yogas)
        yogaPlan.trimester = self.trimester.rawValue
        
        return yogaPlan
    }
}
