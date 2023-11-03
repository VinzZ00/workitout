//
//  HomeViewModel.swift
//  WorkItOut
//
//  Created by Jeremy Raymond on 31/10/23.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var week: Int = 20
    @Published var yogaPlan: YogaPlan = YogaPlan()
    
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
    
    init(profile: Profile = Profile()) {
        self.week = profile.currentPregnancyWeek
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
