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
    case squattingAndBirthing = "Squatting And Birthing"
    case coolingDown = "Cooling Down"
    
    static func getMainCategories() -> [Category] {
        return [.standingPose, .seatedPose, .hipOpeners, .squattingAndBirthing]
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
        case .squattingAndBirthing:
            return 5
        case .coolingDown:
            return 6
        }
    }
}
