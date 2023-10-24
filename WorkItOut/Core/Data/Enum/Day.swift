//
//  Day.swift
//  CreateWorkoutPlan
//
//  Created by Jeremy Raymond on 23/10/23.
//

import Foundation

enum Day: Int, CaseIterable {
    case monday = 1
    case tuesday = 2
    case wednesday = 3
    case thursday = 4
    case friday = 5
    case saturday = 6
    case sunday = 7
    
    func getDay() -> String {
        switch self {
            case .monday:
                return "Monday"
            case .tuesday:
                return "Tuesday"
            case .wednesday:
                return "Wednesday"
            case .thursday:
                return "Thursday"
            case .friday:
                return "Friday"
            case .saturday:
                return "Saturday"
            case .sunday:
                return "Sunday"
        }
    }
    
    func getWeekday() -> Date {
        let today = Date()
        let calendar = Calendar.current
        let dayOfWeek = calendar.component(.weekday, from: today)
        
        let adjustedDayOfWeek = (dayOfWeek - calendar.firstWeekday + self.rawValue) % 7
        
        let adjustedDate = calendar.date(byAdding: .day, value: adjustedDayOfWeek, to: today)
        
        return adjustedDate ?? Date.now
    }
}

//var d = Date()

//print(Calendar.current.dateComponents([.weekday], from: d).weekday)
