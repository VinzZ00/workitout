//
//  AssessmentState.swift
//  WorkItOut
//
//  Created by Kevin Dallian on 24/10/23.
//

import Foundation

enum AssessmentState: Int, CaseIterable {
    case chooseWeek = 0
    case chooseExceptions
    case chooseDay
    case chooseDuration
    case chooseExperience
    case chooseTime
    
//    case chooseMonth
//    case chooseTrimester
//    case chooseRelieve
    
    case complete
    
    
}
