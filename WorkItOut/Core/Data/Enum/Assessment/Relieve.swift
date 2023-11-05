//
//  Relieve.swift
//  WorkItOut
//
//  Created by Jeremy Raymond on 29/10/23.
//

import Foundation

enum Relieve: String, UserPreference {
    func getString() -> String {
        return self.rawValue
    }
    
    case back = "Back"
    case hip = "Hip"
    case neck = "Neck"
    case leg = "Leg"
    case pelvic = "Pelvic"
    case sciatic = "Sciatic"
    case ankle = "Ankle"
    case foot = "Foot"
    case knee = "Knee"
}
