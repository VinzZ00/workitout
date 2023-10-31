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
    
    func getDescription() -> String {
        var desc = ""
        switch self {
        case .beginner:
            desc = "None at all"
        case .intermediate:
            desc = "A little bit"
        case .advanced:
            desc = "I do yoga often"
        }
        return desc
    }
    
    func getString() -> String {
        return self.rawValue
    }
}
