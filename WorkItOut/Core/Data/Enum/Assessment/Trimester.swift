//
//  Trimester.swift
//  WorkItOut
//
//  Created by Jeremy Raymond on 29/10/23.
//

import Foundation

enum Trimester: String, UserPreference {
    func getString() -> String {
        return self.rawValue
    }
    
  case first = "First Trimester"
  case second = "Second Trimester"
  case third = "Third Trimester"
  case all = "All Available"
}
