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
    case all = "All"
    case none = "None"
}
