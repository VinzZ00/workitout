//
//  TimeOfDay.swift
//  WorkItOut
//
//  Created by Jeremy Raymond on 29/10/23.
//

import Foundation

enum TimeOfDay: String, UserPreference {
    case morning = "Morning"
    case afternoon = "Afternoon"
    case evening = "Evening"
    
    func getString() -> String {
        return self.rawValue
    }
    
    func getLocalizedString() -> LocalizedStringResource {
        switch self {
        case .morning:
            return "Morning"
        case .afternoon:
            return "Afternoon"
        case .evening:
            return "Evening"
        }
    }
}
