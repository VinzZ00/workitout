//
//  PoseHistory.swift
//  Mamaste
//
//  Created by Kevin Dallian on 22/11/23.
//

import CoreData
import Foundation

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
    
    func toPose() -> Pose {
        return Pose(id: self.id,
                    name: self.name,
                    altName: self.altName,
                    category: self.category,
                    difficulty: self.difficulty,
                    image : self.image,
                    description: self.description,
                    seconds: self.seconds,
                    state: self.state
        )
    }
    
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
