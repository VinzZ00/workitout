//
//  RequestYogaPose.swift
//  WorkItOut
//
//  Created by Kevin Dallian on 31/10/23.
//

import Foundation

struct RequestYogaPose {
    var name : String
    var altName : String
    var difficulty : Difficulty
    var position : Position
    var recommendedTrimester : Trimester
    var spineMovement : SpineMovement
    var bodyPartTrained : [BodyPart]
    var exception : [String]
    var relieve : [String]
}
