//
//  Workout.swift
//  WorkItOut
//
//  Created by Elvin Sestomi on 21/10/23.
//

import Foundation
import CoreData
//enum WorkoutState {
//    case onProgress
//    case finished
//}

struct Yoga: Identifiable, Hashable, Entity {
    var id = UUID()
    var name : String
    var poses : [PoseNSObject]
    var day : Day
    var estimationDuration : Int
    var yogaState : YogaState = .notCompleted
    var image: String
    
    static func == (lhs: Yoga, rhs: Yoga) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    func intoNSObject(context : NSManagedObjectContext) -> NSManagedObject{
        let yoga = YogaNSObject(context: context)
        yoga.uuid = UUID()
        yoga.name = self.name
        yoga.day = self.day.rawValue
        yoga.poses?.addingObjects(from: poses.map{$0.ofYoga =  yoga})
        yoga.estimationDuration = Int32(self.estimationDuration)
        yoga.yogaState = self.yogaState.rawValue
        yoga.image = self.image
        return yoga;
    }
    
    func intoYoga(yogaNS : YogaNSObject) -> Yoga {
        return .init(name: <#T##String#>, poses: yogaNS.poses.map{$0.intoPose()}, day: <#T##Day#>, estimationDuration: <#T##Int#>, image: <#T##String#>)
    }

}


