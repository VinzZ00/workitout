//
//  UserPreference.swift
//  WorkItOut
//
//  Created by Jeremy Raymond on 30/10/23.
//

import Foundation

protocol UserPreference: CaseIterable, Hashable {
    func getString() -> String
}
