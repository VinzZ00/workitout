//
//  TimeOfDay.swift
//  WorkItOut
//
//  Created by Jeremy Raymond on 29/10/23.
//

import Foundation

enum TimeOfDay: String, UserPreference {
    func getString() -> String {
        return self.rawValue
    }
    
    case morning = "Morning"
    case afternoon = "Afternoon"
    case evening = "Evening"
}
