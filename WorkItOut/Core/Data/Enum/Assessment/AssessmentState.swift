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
    
    func getTitle() -> String {
        switch self {
        case .chooseWeek:
            return "Pregnancy Weeks"
        case .chooseExceptions:
            return "Health Conditions"
        case .chooseDay:
            return "Weekly Schedule"
        case .chooseDuration:
            return "Yoga Duration in a Session"
        case .chooseTime:
            return "Time Reminder"
        case .chooseExperience:
            return "Yoga Experience"
        case .complete:
            return "Complete"
        }
    }
    
//    case chooseMonth
//    case chooseTrimester
//    case chooseRelieve
    
    case complete
    
    
}
