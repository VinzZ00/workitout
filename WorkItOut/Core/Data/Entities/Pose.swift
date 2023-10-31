//
//  Exercise.swift
//  WorkItOut
//
//  Created by Elvin Sestomi on 21/10/23.
//
import CoreData
import Foundation

enum Exception : String, UserPreference {
    func getString() -> String {
        self.rawValue
    }
    
    case vertigo = "Vertigo"
    case all = "All"
    case none = "None"
}

struct Pose: Identifiable, Hashable, Entity {
    let id: UUID = UUID()
    var name : String
    var image : String?
    var video : String?
    var description : String
    var seconds : Int
    var state : YogaState

    var position : Position
    var recommendedTrimester : Trimester
    var spineMovement : SpineMovement
    var bodyPartTrained : [BodyPart]
    var relieve: [Relieve]
    var exception: [Exception] = []

    var difficulty : Difficulty
    
    func intoNSObject(context : NSManagedObjectContext) -> NSManagedObject {
        var pose = PoseNSObject(context: context)
        
        pose.uuid = UUID()
        pose.name = self.name
        pose.image = self.image
        pose.video = self.video
        pose.poseDescription = self.description
        pose.seconds = Int32(self.seconds)
        pose.state = self.state.rawValue
        pose.category = self.position.rawValue
        pose.recommendedTrimester = self.recommendedTrimester.rawValue
        pose.relieve = self.relieve.map{$0.rawValue}.joined(separator: ", ")
        pose.bodyPartTrained = self.bodyPartTrained.map{$0.rawValue}.joined(separator: ", ")
        pose.difficulty = self.difficulty.rawValue
        
        return pose;
    }
}




