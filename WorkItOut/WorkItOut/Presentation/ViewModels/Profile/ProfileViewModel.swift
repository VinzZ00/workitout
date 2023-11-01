//
//  ProfileViewModel.swift
//  WorkItOut
//
//  Created by Kevin Dallian on 31/10/23.
//

import Foundation

class ProfileViewModel : ObservableObject {
    @Published var profile = Profile(name: "Mamam", currentPregnancyWeek: 3, currentRelieveNeeded: [], fitnessLevel: .beginner, daysAvailable: [.monday, .wednesday, .friday], timeOfDay: .morning, preferredDuration: .thirtyMinutes, plan: [], histories: [])
    
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
    
}
