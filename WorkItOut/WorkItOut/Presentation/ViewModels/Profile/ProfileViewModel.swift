//
//  ProfileViewModel.swift
//  WorkItOut
//
//  Created by Kevin Dallian on 31/10/23.
//

import Foundation

class ProfileViewModel : ObservableObject {
    @Published var profile = Profile(name: "Mamam", currentPregnancyWeek: 3, currentRelieveNeeded: [], fitnessLevel: .beginner, daysAvailable: [.monday, .wednesday, .friday], timeOfDay: .morning, preferredDuration: .thirtyMinutes, plan: [], histories: [])
    @Published var currentWeek: Int = 10
    @Published var exceptions: [Exception] = [.vertigo, .abdominalSurgery, .diastasisRecti]
    @Published var days : [Day] = [.monday]
    @Published var timeClock : TimeOfDay = .morning
    @Published var durationExercise : Duration = .fiveteenMinutes
    @Published var timeSpan : Months = .oneMonth
    @Published var experience: Difficulty = .beginner
    @Published var trimester: Trimester = .first
    @Published var relieve: [Relieve] = [.backpain]
//    @Published var exceptions: [Exception] = [.highBloodPressure]
    
    init(){
        // MARK: change to load profile from coredata
        self.profile = Profile(name: "Mamam", currentPregnancyWeek: 3, currentRelieveNeeded: [.backpain, .hippain], fitnessLevel: .beginner, daysAvailable: [.monday, .wednesday, .friday], timeOfDay: .morning, preferredDuration: .thirtyMinutes, plan: [], histories: [])
        
        self.days = self.profile.daysAvailable
        self.timeClock = self.profile.timeOfDay
        self.durationExercise = self.profile.preferredDuration
        self.experience = self.profile.fitnessLevel
        // trimester ganti dengan function getTrimesterFromCurrentWeek
        self.relieve = self.profile.currentRelieveNeeded
        
    }
    
    func convertToString(days : [Day]) -> String{
        let strings = days.map { day in
            switch day {
            case .monday:
                return "Mon"
            case .tuesday:
                return "Tue"
            case .wednesday:
                return "Wed"
            case .thursday:
                return "Thurs"
            case .friday:
                return "Fri"
            case .saturday:
                return "Sat"
            case .sunday:
                return "Sun"
            }
        }
        return strings.joined(separator: ", ")
    }
    
    func convertToStrings(relieves: [Relieve]) -> String {
        let strings = relieves.map { $0.getString() }
        return strings.joined(separator: ", ")
    }
    
    func convertToStrings(exceptions : [Exception]) -> String {
        let strings = exceptions.map { $0.getString() }
        return strings.joined(separator: ", ")
    }
    
    func convertToStrings(currentPregnancyWeek : Int) -> String {
        let trimester = getTrimester(currentPregnancyWeek)
        let string = "Week \(currentPregnancyWeek) (Trimester \(trimester))"
        return string
    }
    
    private func getTrimester(_ currentPregnancyWeek : Int) -> Int {
        var trimester = 0
        if currentPregnancyWeek >= 0 && currentPregnancyWeek <= 12 {
            trimester = 1
        }else if currentPregnancyWeek >= 12 && currentPregnancyWeek <= 24 {
            trimester = 2
        }else{
            trimester = 3
        }
        return trimester
    }
    
    func saveProfile(){
        self.profile.currentPregnancyWeek = 2
        self.profile.currentRelieveNeeded = relieve
        self.profile.daysAvailable = days
        self.profile.fitnessLevel = experience
        self.profile.preferredDuration = durationExercise
        self.profile.timeOfDay = timeClock
        self.objectWillChange.send()
    }
    
    func saveToCoreData(){
        // Logic for saving to core data
    }
    
    func revertProfile(){
        self.relieve = self.profile.currentRelieveNeeded
        self.days = self.profile.daysAvailable
        self.experience = self.profile.fitnessLevel
        self.durationExercise = self.profile.preferredDuration
        self.timeClock = self.profile.timeOfDay
    }
}
