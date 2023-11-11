//
//  Duration.swift
//  WorkItOut
//
//  Created by Kevin Dallian on 24/10/23.
//

import Foundation

enum Duration : String, UserPreference {
    case tenMinutes = "10 Minutes"
    case twentyMinutes = "20 Minutes"
    case thirtyMinutes = "30 Minutes"
    
    func getString() -> String {
        return self.rawValue
    }
    
    var localizedString: LocalizedStringResource {
        switch self {
        case .tenMinutes:
            return "10 Minutes"
        case .twentyMinutes:
            return "20 Minutes"
        case .thirtyMinutes:
            return "30 Minutes"
        }
    }
    
    func getDurationInMinutes() -> Int {
        switch self {
        case .tenMinutes:
            return 10
        case .twentyMinutes:
            return 20
        case .thirtyMinutes:
            return 30
        }
    }
    
    func getDurationInSeconds() -> Int {
        switch self {
            case .tenMinutes:
                return 10*60
            case .twentyMinutes:
                return 20*60
            case .thirtyMinutes:
                return 30*60
        }
    }
    
    
}
