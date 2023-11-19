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
    
    static func getTrimesterExceptAll() -> [Trimester] {
        return [.first, .second, .third]
    }
    
    func getString() -> String {
        return self.rawValue
    }
    
    func getRomanString() -> String {
        switch self {
        case .first:
            return "Trimester I"
        case .second:
            return "Trimester II"
        case .third:
            return "Trimester III"
        case .all:
            return "Trimester X"
        }
    }
    
    func getLocalizedString() -> LocalizedStringResource {
        switch self {
        case .first:
            return "First"
        case .second:
            return "Second"
        case .third:
            return "Third"
        case .all:
            return "All"
        }
    }
    
    func getLocalizedDescription() -> LocalizedStringResource {
        switch self {
        case .first:
            return "First Trimester"
        case .second:
            return "Second Trimester"
        case .third:
            return "Third Trimester"
        case .all:
            return "All Trimester"
        }
    }
    
    func getDescription() -> String {
        return self.getLocalizedDescription().stringValue()
    }
    
    func getInt() -> Int {
        switch self {
        case .first:
            return 1
        case .second:
            return 2
        case .third:
            return 3
        case .all:
            return 0
        }
    }
    
    func getTitle() -> LocalizedStringResource {
        switch self {
        case .first:
            return "First Trimester: Beginnings and Growth"
        case .second:
            return "Second Trimester: Blossoming Strength"
        case .third:
            return "Third Trimester: Harmony and Culmination"
        case .all:
            return "Third Trimester: Harmony and Culmination"
        }
    }
    
    func getDesc() -> LocalizedStringResource {
        switch self {
        case .first:
            return "Lay the foundation for your yoga journey with foundational poses and alignment."
        case .second:
            return "Experience a surge of energy as you embrace challenging poses and cultivate physical prowess."
        case .third:
            return "Celebrate the culmination of your yoga journey with a harmonious blend of strength, flexibility, and serenity."
        case .all:
            return "Celebrate the culmination of your yoga journey by finding harmony on and off the mat, integrating strength, flexibility, and serenity for a fulfilling and balanced practice."
        }
    }
}
