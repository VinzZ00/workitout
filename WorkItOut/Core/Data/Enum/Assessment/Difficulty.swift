//
//  Difficulty.swift
//  WorkItOut
//
//  Created by Jeremy Raymond on 29/10/23.
//

import Foundation

enum Difficulty: String, CaseIterable {
    func getString() -> String {
        return self.rawValue
    }
    
    case beginner = "None at all"
    case intermediate = "A little bit"
    case advanced = "I do yoga often"
}
