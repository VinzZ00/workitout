//
//  History.swift
//  WorkItOut
//
//  Created by Jeremy Raymond on 30/10/23.
//

import Foundation
import CoreData


struct PoseHistory : Entity, Identifiable {
    let id: UUID
    var name : String
    var altName: String
    var category: Category
    var difficulty : Difficulty
    var image : String?
    var description : String
    var seconds : Int
    var state : YogaState
    
    func intoNSObject(context: NSManagedObjectContext, parentYogaHistoryNS : YogaHistoryNSObject) -> NSManagedObject {
        let poseHistory = PoseHistoryNSObject(context: context)
        poseHistory.uuid = self.id
        poseHistory.name = self.name
        poseHistory.altName = self.altName
        poseHistory.category = self.category.rawValue
        poseHistory.difficulty = self.difficulty.rawValue
        poseHistory.image = self.image
        poseHistory.poseDescription = self.description
        poseHistory.seconds = Int32(self.seconds)
        poseHistory.state = self.state.rawValue
        return poseHistory
    }
}


struct YogaHistory : Entity, Identifiable {
    var id : UUID
    var name : String
    var poses : [PoseHistory]
    var day : Day
    var estimationDuration : Int
    var yogaState : YogaState
    var image: String
    
    func intoNSObject(context : NSManagedObjectContext, parentHistoryNS : HistoryNSObject) -> NSManagedObject {
        let yogaHistoryNS = YogaHistoryNSObject(context: context)
        yogaHistoryNS.uuid = self.id
        yogaHistoryNS.name = self.name
        yogaHistoryNS.day = self.day.rawValue
        yogaHistoryNS.historyofPoses?.addingObjects(from: poses.map{$0.intoNSObject(context: context, parentYogaHistoryNS: yogaHistoryNS)})
        yogaHistoryNS.estimationDuration = Int32(self.estimationDuration)
        yogaHistoryNS.yogaState = self.yogaState.rawValue
        yogaHistoryNS.image = self.image
        yogaHistoryNS.ofHistory = parentHistoryNS
        return yogaHistoryNS
    }
}

struct History : Entity, Identifiable, Equatable { 
    var id : UUID
    var yogaDone : YogaHistory
    var executionDate : Date
    var duration : Int
    var rating : Int
    
    func intoNSObject(context: NSManagedObjectContext, parentProfileNS : ProfileNSObject) -> NSManagedObject {
        let historyNS = HistoryNSObject(context: context)
        historyNS.uuid = self.id;
        historyNS.executionDate = self.executionDate
        historyNS.rating = Int16(self.rating)
        historyNS.duration = Int32(self.duration)
        historyNS.ofProfile = parentProfileNS
        // MARK: YANG DITAMBAHKAN UNTUK MENGANTIKAN VERSI SEBELUMNYA YANG ARRAY
        historyNS.yogaDone = self.yogaDone.intoNSObject(context: context, parentHistoryNS: historyNS) as? YogaHistoryNSObject
        return historyNS;
    }
    
    static func == (lhs : History, rhs : History) -> Bool {
        return lhs.id == rhs.id
    }
}
