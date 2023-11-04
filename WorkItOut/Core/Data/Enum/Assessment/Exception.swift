//
//  Exception.swift
//  WorkItOut
//
//  Created by Jeremy Raymond on 01/11/23.
//

import Foundation

enum Exception : String, UserPreference {
    func getString() -> String {
        self.rawValue
    }
    
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
}
