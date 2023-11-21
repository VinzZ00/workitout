//
//  History.swift
//  WorkItOut
//
//  Created by Jeremy Raymond on 30/10/23.
//

import Foundation
import CoreData

struct YogaHistory : Entity, Identifiable {
    
    func intoNSObject(context : NSManagedObjectContext, parentHistoryNS : HistoryNSObject) -> NSManagedObject {
        let yoga = YogaHistoryNSObject(context: context)
        yoga.uuid = self.id
        yoga.name = self.name
        yoga.day = self.day.rawValue
        yoga.poses?.addingObjects(from: poses.map{$0.intoNSObject(context: context, ofYoga: yoga)})
        yoga.estimationDuration = Int32(self.estimationDuration)
        yoga.yogaState = self.yogaState.rawValue
        yoga.image = self.image
        yoga.of
        return yoga;
    }
    
    var id : UUID = UUID()
    var name : String = "Yoga Name"
    var poses : [Pose] = []
    var day : Day = .monday
    var estimationDuration : Int = Duration.tenMinutes.getDurationInSeconds()
    var yogaState : YogaState = .notCompleted
    var image: String = "yogaImage.png"
}

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
