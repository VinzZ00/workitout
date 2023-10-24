//
//  AssessmentViewModel.swift
//  WorkItOut
//
//  Created by Kevin Dallian on 24/10/23.
//

import Foundation

class AssessmentViewModel : ObservableObject {
    @Published var day : [String] = ["Monday"]
    @Published var timeClock : String = "Morning"
    @Published var durationExercise : String = "15-30 minutes"
    @Published var timeSpan : String = "1 Month"
    @Published var muscleGroup : [String] = ["Chest"]
    @Published var state : AssessmentState = .chooseDay
    
    public func nextState(){
        switch state {
        case .chooseDay:
            state = .chooseTime
        case .chooseTime:
            state = .chooseDuration
        case .chooseDuration:
            state = .chooseMonth
        case .chooseMonth:
            state = .chooseMuscleGroup
        case .chooseMuscleGroup:
            state = .complete
        default:
            return
        }
    }
    
    public func previousState(){
        switch state {
        case .chooseTime:
            state = .chooseDay
        case .chooseDuration:
            state = .chooseTime
        case .chooseMonth:
            state = .chooseDuration
        case .chooseMuscleGroup:
            state = .chooseMonth
        default:
            return
        }
    }
}
