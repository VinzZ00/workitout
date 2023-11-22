//
//  YogaHistory.swift
//  Mamaste
//
//  Created by Elvin Sestomi on 21/11/23.
//

import CoreData
import Foundation

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
