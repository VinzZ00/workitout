//
//  ProfileViewModel.swift
//  WorkItOut
//
//  Created by Kevin Dallian on 31/10/23.
//

import Foundation

class ProfileViewModel : ObservableObject {
    @Published var profile = Profile(name: "Mamam", currentWeek: Date.now, currentRelieveNeeded: [], fitnessLevel: .beginner, daysAvailable: [.monday, .wednesday, .friday], timeOfDay: .morning, preferredDuration: .thirtyMinutes, plan: [YogaPlan()], histories: [])
    
    func convertToString(days : [Day]) -> String{
        var strings = days.map { day in
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
    
}
