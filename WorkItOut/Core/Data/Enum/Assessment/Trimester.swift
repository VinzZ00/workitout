//
//  Trimester.swift
//  WorkItOut
//
//  Created by Jeremy Raymond on 29/10/23.
//

import Foundation

enum Trimester: String, UserPreference {
    case first = "First"
    case second = "Second"
    case third = "Third"
    case all = "All"
    
    func getString() -> String {
        return self.rawValue
    }
    
    func getDescription() -> String {
        var desc = ""
        switch self {
        case .first:
            desc = "First Trimester"
        case .second:
            desc = "Second Trimester"
        case .third:
            desc = "Third Trimester"
        case .all:
            desc = "All Available"
        }
        return desc
    }
}
