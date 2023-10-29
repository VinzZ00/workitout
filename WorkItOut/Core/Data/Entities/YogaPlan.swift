//
//  WorkoutPlan.swift
//  WorkItOut
//
//  Created by Jeremy Raymond on 23/10/23.
//

import Foundation

struct YogaPlan : Identifiable {
    let id: UUID = UUID()
    var name: String
    var yogas: [Yoga] = []
}
