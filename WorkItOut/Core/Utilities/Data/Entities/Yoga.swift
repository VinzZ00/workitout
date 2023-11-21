//
//  Workout.swift
//  WorkItOut
//
//  Created by Elvin Sestomi on 21/10/23.
//

import Foundation
import CoreData

struct Yoga: Identifiable, Hashable, Entity {
    var id : UUID = UUID()
    var name : String = "Yoga Name"
    var poses : [Pose] = []
    var day : Day = .monday
    var estimationDuration : Int = Duration.tenMinutes.getDurationInSeconds()
    var yogaState : YogaState = .notCompleted
    var image: String = "yogaImage.png"
    
    func totalDurationMinute() -> Int {
        var seconds = 0
        
        for pose in poses {
            seconds += pose.seconds
        }
        
        return (seconds/60)
    }
    
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
        yoga.poses?.addingObjects(from: poses.map{ $0.intoNSObject(context: context, ofYoga: yoga) })
        yoga.estimationDuration = Int32(self.estimationDuration)
        yoga.yogaState = self.yogaState.rawValue
        yoga.image = self.image
        yoga.ofYogaPlan = parentYogaPlanNS
        return yoga;
    }
    
    func generateYogaHistory() -> YogaHistory {
        YogaHistory(id: self.id, name: self.name, poses: self.poses, day: self.day, estimationDuration: self.estimationDuration, yogaState: self.yogaState, image: self.image)
    }

}


