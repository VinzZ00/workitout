//
//  HomeViewModel.swift
//  WorkItOut
//
//  Created by Jeremy Raymond on 31/10/23.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var week: Int = 20
    var yogaPlans: [YogaPlan] = []
    @Published var day: Day = .monday
    
    @Published var days: [Day] = Day.allCases
    @Published var relieves: [Relieve] = [
        .backpain, .breathing, .hippain, .laborprep, .neckcramp, .pelvicflexibility
    ]
    @Published var selectedRelieve: Relieve = .backpain
    @Published var sheetToggle: Bool = false
    
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
    
    init(profile: Profile = Profile()) {
        self.week = profile.currentPregnancyWeek
        self.days = profile.daysAvailable
        self.yogaPlans = profile.plan
    }
    
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
}
