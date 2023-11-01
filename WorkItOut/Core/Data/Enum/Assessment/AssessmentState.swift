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
    
    func getDescription() -> (String, String) {
        var title = ""
        var description = ""
        switch self {
        case .chooseDay:
            title = "Weekly Schedule"
            description = "What availability day to commit to yoga each week?"
        case .chooseTime:
            title = "Time Reminder"
            description = "When do you want to be reminded to do yoga?"
        case .chooseDuration:
            title = "Yoga Duration in a Session"
            description = "How much time do you have to commit to yoga in a session?"
        case .chooseMonth:
            title = "Pregnancy Weeks"
            description = "What weeks of pregnancy are you in?"
        case .chooseExperience:
            title = "Yoga Experience"
            description = "Have you ever done yoga before?"
        case .chooseRelieve:
            title = "Health conditions"
            description = "Do you have any health conditions that could affect your yoga?"
        default:
            title = ""
            description = ""
        }
        return (title, description)
    }
    
}
