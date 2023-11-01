//
//  DataManager.swift
//  WorkItOut
//
//  Created by Jeremy Raymond on 31/10/23.
//

import Foundation

class DataManager: ObservableObject {
    let pm: PoseManager = PoseManager()
    var profile: Profile
    
    init() {
        profile = Profile(name: "", currentPregnancyWeek: 3, currentRelieveNeeded: [], fitnessLevel: .beginner, daysAvailable: [], timeOfDay: .morning, preferredDuration: .fiveteenMinutes, plan: [], histories: [])
    }
    
    public func createProfile(name: String, currentWeek: Int, currentRelieveNeeded: [Relieve], fitnessLevel: Difficulty, daysAvailable: [Day], timeOfDay: TimeOfDay, preferredDuration: Duration, plan: [YogaPlan], histories: [History]) -> Profile {
        
        let profile: Profile = Profile(name: name, currentPregnancyWeek: currentWeek, currentRelieveNeeded: currentRelieveNeeded, fitnessLevel: fitnessLevel, daysAvailable: daysAvailable, timeOfDay: timeOfDay, preferredDuration: preferredDuration, plan: plan, histories: histories)
        
        return profile
    }
    
    public func createYogas(days: [Day]) -> [Yoga] {
        var yogas: [Yoga] = []
        
        for day in days {
            yogas.append(Yoga(id: UUID(), name: "Test Yoga Name", poses: [], day: day, estimationDuration: 3, image: "ExampleImage.png"))
        }
        
        return yogas
    }
    
    public func createYogaPlan() -> YogaPlan {
        let yogaPlan: YogaPlan = YogaPlan(id: UUID(), name: "Yoga Plan Name", yogas: [], trimester: .second)
        
        return yogaPlan
    }
}
