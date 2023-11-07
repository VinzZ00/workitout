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
    @Published var nextView: Bool = false
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
    
    func checkCategory(poses: [Pose], category: Category) -> Bool {
        if (poses.first(where: {$0.category == category}) != nil) {
            return true
        }
        return false
    }
    
    func existingCategories(poses: [Pose]) -> [Category] {
        var categories: [Category] = []
        for pose in poses {
            if !categories.contains(where: {$0 == pose.category}) {
                categories.append(pose.category)
            }
        }
        
        categories.sort(by: {$0.getOrder() < $1.getOrder()})
        return categories
    }
    
    func getPosesByCategory(poses: [Pose], category: Category) -> [Pose] {
        var newPoses: [Pose] = []
        for pose in poses {
            if pose.category == category {
                newPoses.append(pose)
            }
        }
        
        return newPoses
    }
}
