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
    
    func getDateByDay() -> Date {
        let calendar = Calendar.current
        let today = Date()
        
        // Get the start of the week
        let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: today))!
        
        // Iterate through the days of the week
        let date = calendar.date(byAdding: .day, value: self.getInt(), to: startOfWeek)
        
        return date!
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

        var weekDayInt: Int {
            switch self {
            case .monday:
                return 2
            case .tuesday:
                return 3
            case .wednesday:
                return 4
            case .thursday:
                return 5
            case .friday:
                return 6
            case .saturday:
                return 7
            case .sunday:
                return 1
            }
        }
        
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.weekOfYear = week
        dateComponents.weekday = weekDayInt

        guard let date = calendar.date(from: dateComponents) else {
            fatalError("date didn't valid, from dateForWeekDay(weekday: Day, week: Int, year: Int) -> Int")
        }
        
        return date
        
    }
    
    static func getDayFromInt(int : Int) -> Day {
        if int == 1 {
            return .sunday
        }else if int == 2 {
            return .monday
        }else if int == 3 {
            return .tuesday
        }else if int == 4 {
            return .wednesday
        }else if int == 5 {
            return .thursday
        }else if int == 6 {
            return .friday
        }
        return .saturday
    }
}


