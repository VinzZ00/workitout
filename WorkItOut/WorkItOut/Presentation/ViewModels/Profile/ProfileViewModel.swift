//
//  ProfileViewModel.swift
//  WorkItOut
//
//  Created by Kevin Dallian on 31/10/23.
//

import CoreData
import Foundation

@MainActor
class ProfileViewModel : ObservableObject {
    @Published var profile = Profile()
    // Form Identity
    @Published var currentPregnancyWeek: Int = 10
    @Published var exceptions: [Exception] = []
    @Published var daysAvailable : [Day] = [.monday]
    @Published var timeOfDay : TimeOfDay = .morning
    @Published var preferredDuration : Duration = .tenMinutes
    @Published var fitnessLevel: Difficulty = .beginner
    @Published var trimester: Trimester = .first
    @Published var relieves: [Relieve] = [.back]
    
    // View Purpose
    @Published var currentState : AssessmentState = .chooseDay
    @Published var showSheet = false
    @Published var showAlert = false
    var updateCoreData : UpdateProfileUseCase = UpdateProfileUseCase()
    
    let timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
    @Published var timeRemaining: Double = 2
    
    init(profile : Profile = Profile(name: "Mamam", currentPregnancyWeek: 3, currentRelieveNeeded: [.back, .leg], fitnessLevel: .beginner, daysAvailable: [.monday, .wednesday, .friday], timeOfDay: .morning, preferredDuration: .tenMinutes, plan: [], histories: [])){
        // MARK: change to load profile from coredata
        self.profile = profile
        self.daysAvailable = self.profile.daysAvailable
        self.timeOfDay = self.profile.timeOfDay
        self.preferredDuration = self.profile.preferredDuration
        self.fitnessLevel = self.profile.fitnessLevel
        self.exceptions = self.profile.exceptions
        self.currentPregnancyWeek = self.profile.currentPregnancyWeek
        self.relieves = self.profile.currentRelieveNeeded
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
    
    func setProfile() {
        self.profile.currentPregnancyWeek = currentPregnancyWeek
        self.profile.currentRelieveNeeded = relieves
        self.profile.daysAvailable = daysAvailable
        self.profile.fitnessLevel = fitnessLevel
        self.profile.preferredDuration = preferredDuration
        self.profile.timeOfDay = timeOfDay
        self.profile.exceptions = exceptions
    }
    
    func saveProfile(moc: NSManagedObjectContext) async {
        
        self.objectWillChange.send()
        do {
            try await saveToCoreData(moc: moc)
        }catch {
            
        }
        
    }
    
    func saveToCoreData(moc: NSManagedObjectContext) async throws{
        // Logic for saving to core data
        try await updateCoreData.call(profile: self.profile, context: moc)
    }
    
    func revertProfile(){
        self.relieves = self.profile.currentRelieveNeeded
        self.daysAvailable = self.profile.daysAvailable
        self.fitnessLevel = self.profile.fitnessLevel
        self.preferredDuration = self.profile.preferredDuration
        self.profile.exceptions = exceptions
        self.timeOfDay = self.profile.timeOfDay
    }
    
    func showSheetwithState(state : AssessmentState){
        self.currentState = state
        self.showSheet = true
    }
    
    func equalWithProfile() -> Bool {
        return profile.currentPregnancyWeek == currentPregnancyWeek &&
        profile.exceptions == exceptions &&
        profile.daysAvailable == daysAvailable &&
        profile.timeOfDay == timeOfDay &&
        profile.preferredDuration == preferredDuration &&
        profile.fitnessLevel == fitnessLevel &&
        profile.currentRelieveNeeded == relieves
    }
    
    func checkTimer(load: Bool) -> Bool {
        if load {
            if timeRemaining > 0 {
                timeRemaining -= 0.5
                return false
            }
            else {
                return true
            }
        }
        return false
    }
    
    func resetTimer() {
        self.timeRemaining = 2
    }
}
