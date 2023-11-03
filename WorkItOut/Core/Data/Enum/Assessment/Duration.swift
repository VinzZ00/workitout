//
//  Duration.swift
//  WorkItOut
//
//  Created by Kevin Dallian on 24/10/23.
//

import Foundation

enum Duration : String, UserPreference {
    func getString() -> String {
        return self.rawValue
    }
    
    func getDurationInSeconds() -> Int {
        switch self {
            case .fiveteenMinutes:
                return 15
            case .thirtyMinutes:
                return 30
            case .fourtyFiveMinutes:
                return 45
            case .sixtyMinutes:
                return 60
        }
    }
    
    case fiveteenMinutes = "15-30 minutes"
    case thirtyMinutes = "30-45 minutes"
    case fourtyFiveMinutes = "45-60 minutes"
    case sixtyMinutes = "More than 60 minutes"
}
