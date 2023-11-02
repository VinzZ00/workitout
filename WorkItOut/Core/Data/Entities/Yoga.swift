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
    var id : UUID
    var name : String
    var poses : [Pose]
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
    
    func intoNSObject(context : NSManagedObjectContext, parentYogaPlanNS: YogaPlanNSObject) -> NSManagedObject{
        let yoga = YogaNSObject(context: context)
        yoga.uuid = self.id
        yoga.name = self.name
        yoga.day = self.day.rawValue
        yoga.poses?.addingObjects(from: poses.map{ p in
            let nspose = PoseNSObject(context: context)
            nspose.uuid = p.id
            nspose.name = p.name
            nspose.bodyPartTrained = p.bodyPartTrained.map{$0.rawValue}.joined(separator: ", ")
            nspose.image = p.image
            nspose.video = p.video
            nspose.poseDescription = p.description
            nspose.seconds = Int32(p.seconds)
            nspose.state = p.state.rawValue
            nspose.position = p.position.rawValue
            nspose.spineMovement = p.spineMovement.rawValue
            nspose.recommendedTrimester = p.recommendedTrimester.rawValue
            nspose.relieve = p.relieve.map{$0.rawValue}.joined(separator: ", ")
            nspose.exception  = p.exception.map{$0.rawValue}.joined(separator: ", ")
            nspose.difficulty = p.difficulty.rawValue;
            nspose.ofYoga = yoga
            return nspose;
        })
        yoga.estimationDuration = Int32(self.estimationDuration)
        yoga.yogaState = self.yogaState.rawValue
        yoga.image = self.image
        yoga.ofYogaPlan = parentYogaPlanNS
        return yoga;
    }
    
    func intoNSObject(context : NSManagedObjectContext, parentHistoryNS : HistoryNSObject) -> NSManagedObject {
        let yoga = YogaNSObject(context: context)
        yoga.uuid = self.id
        yoga.name = self.name
        yoga.day = self.day.rawValue
        yoga.poses?.addingObjects(from: poses.map{ p in
            let nspose = PoseNSObject(context: context)
            nspose.uuid = p.id
            nspose.name = p.name
            nspose.bodyPartTrained = p.bodyPartTrained.map{$0.rawValue}.joined(separator: ", ")
            nspose.image = p.image
            nspose.video = p.video
            nspose.poseDescription = p.description
            nspose.seconds = Int32(p.seconds)
            nspose.state = p.state.rawValue
            nspose.position = p.position.rawValue
            nspose.spineMovement = p.spineMovement.rawValue
            nspose.recommendedTrimester = p.recommendedTrimester.rawValue
            nspose.relieve = p.relieve.map{$0.rawValue}.joined(separator: ", ")
            nspose.exception  = p.exception.map{$0.rawValue}.joined(separator: ", ")
            nspose.difficulty = p.difficulty.rawValue;
            nspose.ofYoga = yoga
            return nspose;
        })
        yoga.estimationDuration = Int32(self.estimationDuration)
        yoga.yogaState = self.yogaState.rawValue
        yoga.image = self.image
        yoga.ofHistory = parentHistoryNS
        return yoga;
    }
    
    
//    dm: <#T##DataManager#>, 

}


