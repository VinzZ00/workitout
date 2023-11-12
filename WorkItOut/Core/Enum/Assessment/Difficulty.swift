//
//  Difficulty.swift
//  WorkItOut
//
//  Created by Jeremy Raymond on 29/10/23.
//

import Foundation

enum Difficulty: String, UserPreference {
    case beginner = "Beginner"
    case intermediate = "Intermediate"
    case advanced = "Advanced"
    
    func getString() -> String {
        return self.rawValue
    }
    
    func getLocalizedString() -> LocalizedStringResource {
        switch self {
        case .beginner:
            return "Beginner"
        case .intermediate:
            return "Intermidiate"
        case .advanced:
            return "Advanced"
        }
    }
    
    func getDescription() -> String {
        return self.getLocalizedDescription().stringValue()
    }
    
    func getLocalizedDescription() -> LocalizedStringResource {
        switch self {
            case .beginner:
                return "None at all"
            case .intermediate:
                return "A little bit"
            case .advanced:
                return "I do yoga often"
        }
    }
    
    
}
