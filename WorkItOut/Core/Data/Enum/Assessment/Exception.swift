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
    
    case vertigo = "Vertigo"
    case highBloodPressure = "High Blood Pressure"
    case diastasisRecti = "Diastatis Recti"
    case preTermLabor = "PreTerm Labor"
    case abdominalSurgery = "Abdominal Surgery"
    case lowBloodPressure = "Low Blood Pressure"
    case orthopedicIssues = "Orthopedic Issues"
}
