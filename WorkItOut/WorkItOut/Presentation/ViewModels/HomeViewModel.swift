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
    @Published var yogaPlans: [YogaPlan] = []
    @Published var day: Day = .monday
    @Published var profile : Profile = Profile()
    @Published var currentYoga: Yoga = Yoga()
    
    @Published var days: [Day] = Day.allCases
    @Published var relieves: [Relieve] = [
        .leg, .back, .hip
    ]
    @Published var selectedRelieve: Relieve = .back
    @Published var sheetToggle: Bool = false
    @Published var nextView: Bool = false
    @Published var fetch = FetchProfileUseCase()
    @Published var selectedDate = Date()
    @Published var showHeader: Bool = true
    @Published var showProfile: Bool = false
    
    @Published var handmadeYogaPlans: [Relieve : [YogaPlan]] = [:]
    
    init(profile: Profile = Profile()) {
        self.week = profile.currentPregnancyWeek
        self.days = profile.daysAvailable
        self.yogaPlans = profile.plan
        self.profile = profile
    }
    

    func loadProfile(moc : NSManagedObjectContext) async throws {
        let fetchedProfile = try await fetch.call(context: moc)
        if fetchedProfile.isEmpty {
            throw URLError(.badServerResponse)
        }else{
            self.profile = fetchedProfile.last!
            self.week = self.profile.currentPregnancyWeek
            self.days = self.profile.daysAvailable
            self.yogaPlans = self.profile.plan
            
            if !profile.plan.isEmpty {
                self.initHandmadeYogaPlans()
                print("handmade loaded")
            }
            
            self.objectWillChange.send()
        }
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
    
    
    func initMonth() {
        
        let DisplayWeek = self.week /* checkingWeek */ - self.profile.currentPregnancyWeek /* weekXpreg; */
        
        // MARK: TO GET THE CURRENT WEEK OF THE YEAR
        let calendar = Calendar.current
        let currentDate = Date()
        let pregDate = calendar.date(byAdding: .weekOfYear, value: -self.profile.currentPregnancyWeek, to: currentDate)
        let weekOfPreg = calendar.dateComponents([.weekOfYear], from: pregDate!)
        let woy = self.profile.currentPregnancyWeek + weekOfPreg.weekOfYear! + DisplayWeek
        
        // MARK: TO GET CURRENT YEAR
        let year = calendar.dateComponents([.year], from: currentDate).year!
        
        // MARK: TO GET THE CURRENT DATE OF THE WEEKDAY
        let displayDate = day.dateForWeekday(week: woy, year: year);
        
        self.selectedDate = displayDate
        
        let df = DateFormatter()
        df.dateFormat = "MMMM"
        
        self.month = df.string(from: displayDate);
    }
    
    
    @Published var month: String = ""
    
    var yogaPlan: YogaPlan? {
        return yogaPlans.first(where: {$0.trimester == trimester})
    }
    
    var yoga: Yoga? {
        return yogaPlan?.yogas.first(where: {$0.day == day})
    }
    
    func previousWeek() {
        if self.week > 1 {
            self.week -= 1
        }
    }
    
    func nextWeek() {
        if self.week < 32 {
            self.week += 1
        }
    }
    
    func initHandmadeYogaPlans() {
        if self.handmadeYogaPlans.isEmpty {
            for relieve in Relieve.allCases {
                self.handmadeYogaPlans[relieve] = self.profile.plan
                for i in 0..<Trimester.allCases.count {
                    self.handmadeYogaPlans[relieve]?[i].name = YogaNames.yogaRelieveNames[relieve]?[i] ?? "Balancing and Grounding"
                    for j in 0..<self.handmadeYogaPlans[relieve]![i].yogas.count {
                        self.handmadeYogaPlans[relieve]?[i].yogas[j].name = YogaNames.yogaRelieveNames[relieve]?[i] ?? "Balancing and Grounding"
                    }
                }
            }
        }
    }
    
    func getHandmadeYogaPlans(relieve: Relieve) -> [YogaPlan] {
        return self.handmadeYogaPlans[relieve] ?? self.yogaPlans
    }
}
