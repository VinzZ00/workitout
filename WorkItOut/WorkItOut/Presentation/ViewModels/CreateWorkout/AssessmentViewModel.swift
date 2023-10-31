//
//  AssessmentViewModel.swift
//  WorkItOut
//
//  Created by Kevin Dallian on 24/10/23.
//

import Foundation

class AssessmentViewModel : ObservableObject {
    @Published var day : [Day] = [.monday]
    @Published var timeClock : TimeOfDay = .morning
    @Published var durationExercise : Duration = .fiveteenMinutes
    @Published var timeSpan : Months = .oneMonth
    @Published var experience: Difficulty = .beginner
    @Published var trimester: Trimester = .first
    @Published var relieve: [Relieve] = [.backpain]
    
    @Published var state : AssessmentState = .chooseDay
    @Published var buttonDisable = false
    
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
