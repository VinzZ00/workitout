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
    @Published var timeSpan : String = "One Month"
    @Published var experience: String = "None at all"
    @Published var trimester: String = "First Trimester"
    @Published var relieve: [String] = ["Back Pain"]
    
    @Published var state : AssessmentState = .chooseDay
    @Published var buttonDisable = false
    
//    @Published var muscleGroup : [String] = ["Chest"]
    
    public func nextState(){
        switch state {
        case .chooseDay:
            state = .chooseTime
        case .chooseTime:
            state = .chooseDuration
        case .chooseDuration:
            state = .chooseMonth
        case .chooseMonth:
            state = .chooseExperience
        case .chooseExperience:
            state = .chooseTrimester
        case .chooseTrimester:
            state = .chooseRelieve
        case .chooseRelieve:
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
        case .chooseExperience:
            state = .chooseMonth
        case .chooseTrimester:
            state = .chooseExperience
        case .chooseRelieve:
            state = .chooseTrimester
        case .complete:
            state = .chooseRelieve
        default:
            return
        }
    }
}
