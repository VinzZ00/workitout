//
//  Relieve.swift
//  WorkItOut
//
//  Created by Jeremy Raymond on 29/10/23.
//

import Foundation

enum Relieve: String, UserPreference {
    case back = "Back"
    case hip = "Hip"
    case neck = "Neck"
    case leg = "Leg"
    case pelvic = "Pelvic"
//    case sciatic = "Sciatic"
//    case ankle = "Ankle"
//    case foot = "Foot"
//    case knee = "Knee"
    
    func getString() -> String {
        return self.rawValue
    }
    
    func getLocalizedString() -> LocalizedStringResource {
        switch self {
        case .back:
            return "Back"
        case .hip:
            return "Hip"
        case .neck:
            return "Neck"
        case .leg:
            return "Leg"
        case .pelvic:
            return "Pelvic"
//        case .sciatic:
//            return "Sciatic"
//        case .ankle:
//            return "Ankle"
//        case .foot:
//            return "Foot"
//        case .knee:
//            return "Knee"
        }
    }
}
