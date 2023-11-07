//
//  WorkoutPlan.swift
//  WorkItOut
//
//  Created by Jeremy Raymond on 23/10/23.
//

import Foundation
import CoreData

struct YogaPlan : Identifiable, Entity, Equatable {
    var id: UUID = UUID()
    var name: String = "Yoga Plan Name"
    var yogas: [Yoga] = []
    var trimester: Trimester = .second
    
    static func == (lhs : YogaPlan, rhs : YogaPlan ) -> Bool {
        return lhs.id == rhs.id
    }
    
    func intoNSObject(context : NSManagedObjectContext, parentProfileNSObject : ProfileNSObject) -> NSManagedObject{
        let yogaPlan = YogaPlanNSObject(context: context)
        yogaPlan.uuid = self.id
        yogaPlan.name = self.name
        yogaPlan.yogas?.addingObjects(from: self.yogas.map{ $0.intoNSObject(context: context, parentYogaPlanNS: yogaPlan)})
        yogaPlan.trimester = self.trimester.rawValue
        yogaPlan.ofProfile = parentProfileNSObject
        return yogaPlan
    }
    
    
}
