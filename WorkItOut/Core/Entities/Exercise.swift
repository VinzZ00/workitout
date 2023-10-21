//
//  Exercise.swift
//  WorkItOut
//
//  Created by Elvin Sestomi on 21/10/23.
//

import Foundation

enum MuscleGroup {
    case arm
    case leg
    case chest
    case abs
    case back
}

enum Equipment {
    case dumbbell
    case pullUpBar
    case dipBar
    case noEquipment
}

struct Exercise {
    var name : String
    var muscleGroup : [MuscleGroup]
    var equipment : [Equipment]
    var weight : Double?
    var repetition : Int
    var workoutSet: Int
    var date : Date
}




