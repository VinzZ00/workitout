//
//  AssessmentState.swift
//  WorkItOut
//
//  Created by Kevin Dallian on 24/10/23.
//

import Foundation

enum AssessmentState: Int, CaseIterable {
    case chooseWeek = 0
    case chooseExceptions = 1
    case chooseDay = 2
    case chooseDuration = 3
    case chooseExperience = 4
    case chooseTime = 5
    
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
    
    case complete = 6
    
    func getDescription() -> (String, String) {
        var title = ""
        var description = ""
        
        switch self {
        case .chooseWeek:
            title = "What weeks of pregnancy are you in?"
            description = ""
        case .chooseExceptions:
            title = "Health conditions"
            description = "Do you have any health conditions that could affect your yoga?"
        case .chooseDay:
            title = "Weekly Schedule"
            description = "What availability day to commit to yoga each week?"
        case .chooseDuration:
            title = "Yoga Duration in a Session"
            description = "How much time do you have to commit to yoga in a session?"
        case .chooseExperience:
            title = "Yoga Experience"
            description = "Have you ever done yoga before?"
        case .chooseTime:
            title = "Time Reminder"
            description = "When do you want to be reminded to do yoga?"
        case .complete:
            title = ""
            description = ""
        }
        
        return (title, description)
    }
    
}