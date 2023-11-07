//
//  AssessmentViewModel.swift
//  WorkItOut
//
//  Created by Kevin Dallian on 24/10/23.
//

import Foundation
import CoreData

class AssessmentViewModel : ObservableObject {
    @Published var currentWeek: Int = 10
    @Published var exceptions: [Exception] = [.vertigo, .abdominalSurgery, .diastasisRecti]
    @Published var days : [Day] = [.monday, .wednesday, .sunday]
    @Published var durationExercise : Duration = .tenMinutes
    @Published var experience: Difficulty = .beginner
    @Published var timeClock : TimeOfDay = .morning
    
    
    @Published var timeSpan : Months = .oneMonth
    @Published var trimester: Trimester = .first
    @Published var relieve: [Relieve] = [.back]
    
    @Published var state : AssessmentState = .chooseWeek
    @Published var buttonDisable = false
    @Published var finishCreateYogaPlan: Bool = false
    
    @Published var timeRemaining: Double = 2
    
    func createProfile() ->Profile {
        return Profile(name: "User Name", currentPregnancyWeek: currentWeek, currentRelieveNeeded: relieve, fitnessLevel: experience, daysAvailable: days, timeOfDay: timeClock, preferredDuration: durationExercise, plan: [], histories: [], exceptions: exceptions)
    }
    
    func previousState() {
        self.state = AssessmentState.allCases.first(where: {$0.rawValue == (self.state.rawValue-1)}) ?? .chooseWeek
    }
    
    func nextState() {
        self.state = AssessmentState.allCases.first(where: {$0.rawValue == (self.state.rawValue+1)}) ?? .complete
    }
    
    func checkCategory(poses: [Pose], category: Category) -> Bool {
        if (poses.first(where: {$0.category == category}) != nil) {
            return true
        }
        return false
    }
    
    func resetTimer() {
        self.timeRemaining = 2
    }
}
