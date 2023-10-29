//
//  AssessmentState.swift
//  WorkItOut
//
//  Created by Kevin Dallian on 24/10/23.
//

import Foundation

enum AssessmentState: Int, CaseIterable {
    case chooseDay = 0
    case chooseTime = 1
    case chooseDuration = 2
    case chooseMonth = 3
    case chooseExperience = 4
    case chooseTrimester = 5
    case chooseRelieve = 6
    
//    case chooseMuscleGroup = 4
    case complete = 7
}
