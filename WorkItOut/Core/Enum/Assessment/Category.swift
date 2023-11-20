//
//  Category.swift
//  WorkItOut
//
//  Created by Jeremy Raymond on 04/11/23.
//

import Foundation

enum Category: String, CaseIterable {
    case warmUp = "Warm Up"
    case standingPose = "Standing Pose"
    case seatedPose = "Seated Pose"
    case hipOpeners = "Hip Openers"
    case coolingDown = "Cooling Down"
    
    func getString() -> String {
        return self.getLocalizedString().stringValue()
    }
    
    func getLocalizedString() -> LocalizedStringResource {
        switch self {
        case .warmUp:
            return "Warm Up"
        case .standingPose:
            return "Standing Pose"
        case .seatedPose:
            return "Seated Pose"
        case .hipOpeners:
            return "Hip Openers"
        case .coolingDown:
            return "Cooling Down"
        }
    }
    
    static func getMainCategories() -> [Category] {
        return [.standingPose, .seatedPose, .hipOpeners]
    }
    
    func getOrder() -> Int {
        switch self {
        case .warmUp:
            return 1
        case .standingPose:
            return 2
        case .seatedPose:
            return 3
        case .hipOpeners:
            return 4
        case .coolingDown:
            return 5
        }
    }
}
