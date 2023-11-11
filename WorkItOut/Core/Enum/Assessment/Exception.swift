//
//  Exception.swift
//  WorkItOut
//
//  Created by Jeremy Raymond on 01/11/23.
//

import Foundation

enum Exception : String, UserPreference {
    case highBloodPressure = "High Blood Pressure"
    case lowBloodPressure = "Low Blood Pressure"
    case diastasisRecti = "Diastatis Recti"
    case preTermLabor = "Preterm Labor"
    case knee = "Knee"
    case ankle = "Ankle"
    case hernia = "Hernia"
    case multiples = "Multiples"
    case orthopedicIssues = "Orthopedic Issues"
    
    case abdominalSurgery = "Abdominal Surgery"
    case vertigo = "Vertigo"
    case glucoma = "Glucoma"
    case lackOfFlexibility = "Lack of flexibility"
    
    func getString() -> String {
        self.rawValue
    }
    
    func getLocalizedString() -> LocalizedStringResource {
        switch self {
        case .highBloodPressure:
            return "High Blood Pressure"
        case .lowBloodPressure:
            return "Low Blood Pressuer"
        case .diastasisRecti:
            return "Diastatis Recti"
        case .preTermLabor:
            return "Preterm Labor"
        case .knee:
            return "Knee"
        case .ankle:
            return "Ankle"
        case .hernia:
            return "Hernia"
        case .multiples:
            return "Multiples"
        case .orthopedicIssues:
            return "Orthopedic Issues"
        case .abdominalSurgery:
            return "Abdominal Surgery"
        case .vertigo:
            return "Vertigo"
        case .glucoma:
            return "Glucoma"
        case .lackOfFlexibility:
            return "Lack of Flexibity"
        }
    }
}
