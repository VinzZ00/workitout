//
//  Exercise.swift
//  WorkItOut
//
//  Created by Elvin Sestomi on 21/10/23.
//
import CoreData
import Foundation

struct Pose: Identifiable, Hashable, Comparable, Entity {
    
    
    let id: UUID
    var name : String = "Pose Name"
    var altName: String = "Alternate Name"
    var category: Category = .warmUp
    var difficulty : Difficulty = .beginner
    var exception: [Exception] = [.abdominalSurgery, .diastasisRecti, .highBloodPressure]
    var recommendedTrimester : Trimester = .second
    var relieve: [Relieve] = [.ankle, .back, .foot]
    var status: Status = .necessary
    
    var image : String?
    var video : String?
    var description : String = "Pose Description"
    var instructions: [String] = ["Instruction 1", "Instruction 2", "Instruction 3"]
    var seconds : Int = 60
    var state : YogaState = .notCompleted

//    MARK: Deprecated
//    var position : Position = .stand
//    var spineMovement : SpineMovement = .balance
//    var bodyPartTrained : [BodyPart] = [.arms, .back, .chest]
    
    static func < (lhs: Pose, rhs: Pose) -> Bool {
        lhs.name < rhs.name
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
  
    func intoNSObject(context : NSManagedObjectContext, ofYoga : YogaNSObject) -> NSManagedObject {
        let pose = PoseNSObject(context: context)
        pose.altName = self.altName
        pose.category = self.category.rawValue
        pose.uuid = self.id
        pose.name = self.name
        pose.image = self.image
        pose.video = self.video
        pose.poseDescription = self.description
        pose.seconds = Int32(self.seconds)
        pose.state = self.state.rawValue
        pose.exception = self.exception.map{$0.rawValue}.joined(separator: ", ")
        pose.recommendedTrimester = self.recommendedTrimester.rawValue
        pose.relieve = self.relieve.map{$0.rawValue}.joined(separator: ", ")
        pose.difficulty = self.difficulty.rawValue
        pose.ofYoga = ofYoga
        
//        MARK: Deprecated
//        pose.position = self.position.rawValue
//        pose.spineMovement = self.spineMovement.rawValue
//        pose.bodyPartTrained = self.bodyPartTrained.map{$0.rawValue}.joined(separator: ", ")
        
        return pose;
    }
    
    func intoPose() -> Pose? {
        return nil
    }
}






