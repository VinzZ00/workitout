//
//  Day.swift
//  CreateWorkoutPlan
//
//  Created by Jeremy Raymond on 23/10/23.
//

import Foundation

enum Day: String, CaseIterable {
    case monday = "Monday"
    case tuesday = "Tuesday"
    case wednesday = "Wednesday"
    case thursday = "Thursday"
    case friday = "Friday"
    case saturday = "Saturday"
    case sunday = "Sunday"
    
    func getInt()-> Int {
        switch self {
        case .monday:
            return 1
        case .tuesday:
            return 2
        case .wednesday:
            return 3
        case .thursday:
            return 4
        case .friday:
            return 5
        case .saturday:
            return 6
        case .sunday:
            return 7
        }
    }
    func getWeekday() -> Date {
        let today = Date()
        let calendar = Calendar.current
        let dayOfWeek = calendar.component(.weekday, from: today)
        
        let adjustedDayOfWeek = (dayOfWeek - calendar.firstWeekday + self.getInt()) % 7
        
        let adjustedDate = calendar.date(byAdding: .day, value: adjustedDayOfWeek, to: today)
        
        return adjustedDate ?? Date.now
    }
}

//var d = Date()

//print(Calendar.current.dateComponents([.weekday], from: d).weekday)