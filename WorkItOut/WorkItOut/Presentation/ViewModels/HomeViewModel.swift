//
//  HomeViewModel.swift
//  WorkItOut
//
//  Created by Jeremy Raymond on 31/10/23.
//

import CoreData
import Foundation

@MainActor
class HomeViewModel: ObservableObject {
    @Published var week: Int = 20
    var yogaPlans: [YogaPlan] = []
    @Published var day: Day = .monday
    @Published var profile : Profile = Profile()
    
    @Published var days: [Day] = Day.allCases
    @Published var relieves: [Relieve] = [
        .ankle, .back, .hip
    ]
    @Published var selectedRelieve: Relieve = .back
    @Published var sheetToggle: Bool = false
    @Published var fetch = FetchProfileUseCase()
    
    init(profile: Profile = Profile()) {
        self.week = profile.currentPregnancyWeek
        self.days = profile.daysAvailable
        self.yogaPlans = profile.plan
        self.profile = profile
    }
    
    func loadProfile(moc: NSManagedObjectContext) async {
        let fetchedProfile = await fetch.call(context: moc)
        self.profile = fetchedProfile.last!
        self.week = self.profile.currentPregnancyWeek
        self.days = self.profile.daysAvailable
        self.yogaPlans = self.profile.plan
        self.objectWillChange.send()
    }
    
    func toggleSheet(yoga: Yoga) {
        self.currentYoga = yoga
        self.sheetToggle.toggle()
    }
    
    var trimester: Trimester {
        if week <= 12 {
            return .first
        }
        else if week >= 24 {
            return .third
        }
        else {
            return .second
        }
    }
    
    func getTrimesterRoman() -> String {
        switch trimester {
        case .first:
            return "Trimester I"
        case .second:
            return "Trimester II"
        case .third:
            return "Trimester III"
        case .all:
            return "Trimester"
        }
    }
    
    var month: String {
        let calendar = Calendar.current
        let currentDate = Date()
        
        let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: currentDate))
        let dateComponents = DateComponents(weekOfYear: week)
        if let weekStartDate = calendar.date(byAdding: dateComponents, to: startOfWeek!) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMMM"
            return dateFormatter.string(from: weekStartDate)
        }
        return ""
    }
    
    var yogaPlan: YogaPlan {
        return yogaPlans.first(where: {$0.trimester == trimester}) ?? YogaPlan()
    }
    
    var yoga: Yoga {
        return yogaPlan.yogas.first(where: {$0.day == day}) ?? Yoga()
    }
    
    var currentYoga: Yoga = Yoga()
    
    func previousWeek() {
        if self.week > 0 {
            self.week -= 1
        }
    }
    
    func nextWeek() {
        if self.week < 36 {
            self.week += 1
        }
    }
    
    func dateForWeekday(weekday: Day, week: Int, year: Int) -> Int {
        let calendar = Calendar.current

        var weekDayInt: Int {
            switch weekday {
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
                return 0
            }
        }
        
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.weekOfYear = week
        dateComponents.weekday = weekDayInt

        guard let date = calendar.date(from: dateComponents) else {
            fatalError("date didn't valid, from dateForWeekDay(weekday: Day, week: Int, year: Int) -> Int")
        }
        
        var day = calendar.dateComponents([.day], from: date)
        
        guard let day = day.day else {
            fatalError("Day didn't found, from dateForWeekDay(weekday: Day, week: Int, year: Int) -> Int")
        }

        return day;
        
    }

    

    
    
    func checkCategory(poses: [Pose], category: Category) -> Bool {
        if (poses.first(where: {$0.category == category}) != nil) {
            return true
        }
        return false
    }
}
