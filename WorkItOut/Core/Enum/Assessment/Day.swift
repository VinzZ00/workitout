//
//  Day.swift
//  CreateWorkoutPlan
//
//  Created by Jeremy Raymond on 23/10/23.
//

import Foundation

enum Day: String, UserPreference {
    case sunday = "Sunday"
    case monday = "Monday"
    case tuesday = "Tuesday"
    case wednesday = "Wednesday"
    case thursday = "Thursday"
    case friday = "Friday"
    case saturday = "Saturday"
    
    func getString() -> String {
        return self.rawValue
    }
    
    func getLocalizedString() -> LocalizedStringResource {
        switch self {
            case .sunday:
                return "Sunday"
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
        }
    }
    
    func getShortenedDay() -> String {
        return String(self.getString().prefix(3))
    }
    
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
    
    func dateForWeekday(week: Int, year: Int) -> Date {
        let calendar = Calendar.current

        var weekDayInt: Int = self.getInt()
        
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.weekOfYear = week
        dateComponents.weekday = weekDayInt

        guard let date = calendar.date(from: dateComponents) else {
            fatalError("date didn't valid, from dateForWeekDay(weekday: Day, week: Int, year: Int) -> Int")
        }
        
        return date
    }
}
