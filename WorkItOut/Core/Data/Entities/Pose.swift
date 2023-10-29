//
//  Exercise.swift
//  WorkItOut
//
//  Created by Elvin Sestomi on 21/10/23.
//

import Foundation

//enum MuscleGroup : Int {
//    case arm = 0, leg, chest , abs, back
//    
//    
//}
//
//enum Equipment : Int {
//    case dumbbell = 0
//    case pullUpBar
//    case dipBar
//    case noEquipment
//}
//
struct Pose: Identifiable, Hashable {
    let id: UUID = UUID()
    var name : String
    var relieve: [Relieve]
    var image: String?
    var video: String?
    var description: String
    var category: PoseCategory
    var recommendedTrimester : Trimester
    var bodyPartTrained : [BodyPart]
    var difficulty : Difficulty
    var seconds : DateInterval
    var state : YogaState
}




