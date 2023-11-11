//
//  Day.swift
//  CreateWorkoutPlan
//
//  Created by Jeremy Raymond on 23/10/23.
//

import Foundation

extension Day {
    func test() {
        print("test")
    }
}

enum Day: String, UserPreference {
    private static let constant = Constant.String.Enum.Day.self
    func getString() -> String {
        return self.rawValue
    }
    func getLocalizedString() -> LocalizedStringResource {
        return LocalizedStringResource(stringLiteral: self.rawValue)
    }
    
    case sunday = "Sunday"
    case monday = "Monday"
    case tuesday = "Tuesday"
    case wednesday = "Wednesday"
    case thursday = "Thursday"
    case friday = "Friday"
    case saturday = "Saturday"
    
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
        
//        var day = calendar.dateComponents([.day], from: date)
//        
//        guard let day = day.day else {
//            fatalError("Day didn't found, from dateForWeekDay(weekday: Day, week: Int, year: Int) -> Int")
//        }
//
//        return day;
        
    }
    
//    func getWeekdayInInt() -> Int {
//        let today = Date()
//        let calendar = Calendar.current
//        let day = calendar.component(.day, from: self.getWeekday())
//        
//        return day
//    }
//    
//    func getWeekday() -> Date {
//        let today = Date()
//        let calendar = Calendar.current
//        let dayOfWeek = calendar.component(.weekday, from: today)
//        
//        let adjustedDayOfWeek = (dayOfWeek - calendar.firstWeekday + self.getInt()) % 7
//        
//        let adjustedDate = calendar.date(byAdding: .day, value: adjustedDayOfWeek, to: today)
//        
//        return adjustedDate ?? Date.now
//    }
}

//var d = Date()

//print(Calendar.current.dateComponents([.weekday], from: d).weekday)
