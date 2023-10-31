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
    
    case backpain = "Back Pain"
    case hippain = "Hip Pain"
    case pelvicflexibility = "Pelvic Flexibility"
    case laborprep = "Labor Prep"
    case neckcramp = "Neck Cramp"
    case breathing = "Breathing"
}
