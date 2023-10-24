//
//  MuscleGroup.swift
//  CreateWorkoutPlan
//
//  Created by Jeremy Raymond on 23/10/23.
//

import Foundation

enum MuscleGroup: Int, CaseIterable {
    case arm = 0
    case leg = 1
    case chest = 2
    case abs = 3
    case back = 4
    
    func getMuscle() -> String {
        switch self {
            case .arm:
                return "Arm"
            case .leg:
                return "Leg"
            case .chest:
                return "Chest"
            case .abs:
                return "Abs"
            case .back:
                return "Back"
        }
    }
}

