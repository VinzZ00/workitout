//
//  Exercise.swift
//  WorkItOut
//
//  Created by Elvin Sestomi on 21/10/23.
//

import Foundation

struct Pose: Identifiable, Hashable {
    let id: UUID = UUID()
    var name : String
    var image : String?
    var video : String?
    var description : String
    var seconds : DateInterval
    var state : YogaState

    var category : PoseCategory
    var recommendedTrimester : Trimester
    var bodyPartTrained : [BodyPart]
    var relieve: [Relieve]
    var exception: [Exception] = []

    var difficulty : Difficulty
}




