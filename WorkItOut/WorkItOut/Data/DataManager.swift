//
//  DataManager.swift
//  WorkItOut
//
//  Created by Jeremy Raymond on 31/10/23.
//

import Foundation

class DataManager: ObservableObject {
    let pm: PoseManager = PoseManager()
    @Published var profile: Profile = Profile()
    
    public func setUpProfile(name: String, currentWeek: Int, currentRelieveNeeded: [Relieve], fitnessLevel: Difficulty, daysAvailable: [Day], timeOfDay: TimeOfDay, preferredDuration: Duration, plan: [YogaPlan], histories: [History]) {
        self.profile = createProfile(name: name, currentWeek: currentWeek, currentRelieveNeeded: currentRelieveNeeded, fitnessLevel: fitnessLevel, daysAvailable: daysAvailable, timeOfDay: timeOfDay, preferredDuration: preferredDuration, plan: plan, histories: histories)
        
        for trimester in Trimester.allCases {
            profile.plan.append(createYogaPlan(trimester: trimester))
        }
    }
    
    public func createProfile(name: String, currentWeek: Int, currentRelieveNeeded: [Relieve], fitnessLevel: Difficulty, daysAvailable: [Day], timeOfDay: TimeOfDay, preferredDuration: Duration, plan: [YogaPlan], histories: [History]) -> Profile {
        return Profile(name: name, currentWeek: currentWeek, currentRelieveNeeded: currentRelieveNeeded, fitnessLevel: fitnessLevel, daysAvailable: daysAvailable, timeOfDay: timeOfDay, preferredDuration: preferredDuration, plan: plan, histories: histories)
    }
    
    public func createYogas() -> [Yoga] {
        var yogas: [Yoga] = []
        var days = profile.daysAvailable
        
        for day in days {
            yogas.append(Yoga(name: "Yoga Name", poses: [], day: day, estimationDuration: 20, image: "ExampleImage.png"))
        }
        
        return yogas
    }
    
    public func createYogaPlan(trimester: Trimester) -> YogaPlan {
        var yogaPlan: YogaPlan = YogaPlan(name: "Yoga Plan Name", yogas: createYogas(), trimester: trimester)
        return yogaPlan
    }
}
