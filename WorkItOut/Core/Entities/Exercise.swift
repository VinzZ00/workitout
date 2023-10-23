//
//  Exercise.swift
//  WorkItOut
//
//  Created by Elvin Sestomi on 21/10/23.
//

import Foundation

enum MuscleGroup : Int {
    case arm = 0, leg, chest , abs, back
    
    
}

enum Equipment : Int {
    case dumbbell = 0
    case pullUpBar
    case dipBar
    case noEquipment
}

struct Exercise {
    var name : String
    var muscleGroup : [MuscleGroup]
    var equipment : [Equipment]
    var weight : Double? = 0
    var repetition : Int
    var workoutSet: Int
    
}




