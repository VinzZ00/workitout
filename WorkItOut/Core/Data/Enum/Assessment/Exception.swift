//
//  Exception.swift
//  WorkItOut
//
//  Created by Jeremy Raymond on 30/10/23.
//

import Foundation

enum Exception: String, UserPreference {
    func getString() -> String {
        return self.rawValue
    }
    
    case vertigo = "Vertigo"
    case none = "None"
    case all = "All"
}
