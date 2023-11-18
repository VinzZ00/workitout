//
//  HistoryTests.swift
//  WorkItOutTests
//
//  Created by Kevin Dallian on 03/11/23.
//

import XCTest
import CoreData
@testable import Mamaste


final class HistoryTests: XCTestCase {
    var moc : NSManagedObjectContext?
    var addUsecase : AddProfileUseCase?
    var updateUseCase : UpdateProfileUseCase?
    var historyViewModel : HistoryUtils?
    var fetchUsecase : FetchProfileUseCase?
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        moc = CoreDataManager().container.viewContext
        addUsecase = AddProfileUseCase()
        updateUseCase = UpdateProfileUseCase()
        historyViewModel = HistoryUtils()
        fetchUsecase = FetchProfileUseCase()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        try super.tearDownWithError()
        moc = nil
        addUsecase = nil
        updateUseCase = nil
        historyViewModel = nil
        fetchUsecase = nil
    }
    
    struct HistoryUtils {
        func categorizeHistoryByDate(_ histories : [History]) -> [Date: [History]]{
            var categorizedHistories = [Date: [History]]()
            for history in histories {
                let date = history.executionDate
                
                let day = Calendar.current.component(.day, from: date)
                let dayDate = Calendar.current.date(from: DateComponents(day: day))!
                
                if categorizedHistories[dayDate] == nil{
                    categorizedHistories[dayDate] = []
                }
                
                categorizedHistories[dayDate]?.append(history)
            }
            return categorizedHistories
        }
    }

    
    
    func testCategorizeHistoryByDate() {
        // Initliaze
        let poses = [
            Pose(id: UUID(), name: "Banana", difficulty: .beginner, recommendedTrimester: .all, relieve: [.back, .hip, .leg], description: "Banana", seconds: 60, state: .completed),
            Pose(id: UUID(), name: "Bound Angle", difficulty: .beginner, recommendedTrimester: .second, relieve: [.back, .hip, .leg], description: "Bound Angle", seconds: 60, state: .completed)
        
        ]
        let yoga = Yoga(id: UUID(), name: "Day 1 - Upper Body", poses: poses, day: .monday, estimationDuration: 5, image: "")
        let yoga1 = Yoga(id: UUID(), name: "Day 2 - Lower Body", poses: poses, day: .monday, estimationDuration: 5, image: "")
        let yoga2 = Yoga(id: UUID(), name: "Day 3 - Core Body", poses: poses, day: .monday, estimationDuration: 5, image: "")
        let yoga3 = Yoga(id: UUID(), name: "Day 4 - Upper Body", poses: poses, day: .monday, estimationDuration: 5, image: "")
        var histories : [History] = []
        histories.append(History(id: UUID(), yogaDone: yoga, executionDate: Date.now, duration: 10, rating: 5))
        histories.append(History(id: UUID(), yogaDone: yoga1, executionDate: Date.now, duration: 10, rating: 5))
        histories.append(History(id: UUID(), yogaDone: yoga2, executionDate: Calendar.current.date(byAdding: .day, value: 1, to: Date.now)!, duration: 10, rating: 5))
        histories.append(History(id: UUID(), yogaDone: yoga3, executionDate: Calendar.current.date(byAdding: .day, value: 1, to: Date.now)!, duration: 10, rating: 5))
        
        if let hvm = historyViewModel {
            var categorizedHistory : [Date: [History]] = [Date: [History]]()
            categorizedHistory = hvm.categorizeHistoryByDate(histories)
            
            let keys = categorizedHistory.keys.sorted(by: {$0 > $1})
            XCTAssertEqual(keys.count, 2)
        }
    }
    
    func testSet() {
        var sets : NSSet = [2, 3, 2];

        var set2 = NSSet(set: sets.adding(3))
        var set3 = NSSet(set: set2.adding(4))


        print(set3)
        
        XCTAssertEqual(set3.count, 3)
        
    }
    
    func testSaveHistory() async {
        let poses = [
            Pose(id: UUID(), name: "Banana", difficulty: .beginner, recommendedTrimester: .all, relieve: [.back, .hip, .leg], description: "Banana", seconds: 60, state: .completed),
            Pose(id: UUID(), name: "Bound Angle", difficulty: .beginner, recommendedTrimester: .second, relieve: [.back, .hip, .leg], description: "Bound Angle", seconds: 60, state: .completed)
        
        ]
        let yoga = Yoga(id: UUID(), name: "Day 1 - Upper Body", poses: poses, day: .monday, estimationDuration: 5, image: "")
        let yoga1 = Yoga(id: UUID(), name: "Day 2 - Lower Body", poses: poses, day: .monday, estimationDuration: 5, image: "")
        let yoga2 = Yoga(id: UUID(), name: "Day 3 - Core Body", poses: poses, day: .monday, estimationDuration: 5, image: "")
        
        var histories : [History] = []
        histories.append(History(id: UUID(), yogaDone: yoga, executionDate: Date.now, duration: 10, rating: 5))
        histories.append(History(id: UUID(), yogaDone: yoga1, executionDate: Date.now, duration: 10, rating: 5))
        histories.append(History(id: UUID(), yogaDone: yoga2, executionDate: Calendar.current.date(byAdding: .day, value: 1, to: Date.now)!, duration: 10, rating: 5))
        
        
        if let fetch = fetchUsecase {
            
            var profile : Profile = Profile()
            do{
                profile = try await fetch.call(context: self.moc!).last!
            }catch let error{
                print(error)
            }
            
            profile.histories.append(contentsOf: histories)
            if let update = updateUseCase {
                do{
                    try await update.call(profile: profile, context: moc!)
                }catch let error {
                    print(error)
                }
                
                if let fetch = fetchUsecase {
                    do{
                        let fetchedProfile = try await fetch.call(context: moc!).last!
                        XCTAssertEqual(fetchedProfile.histories.count, profile.histories.count, "First Done")
                    }catch let error {
                        print(error)
                    }
                    
                }
            }
            var profileNew : Profile = Profile()
            do{
                profileNew = try await fetch.call(context: self.moc!).last!
            }catch let error {
                print(error)
            }
            
            let poses = [
                Pose(id: UUID(), name: "Banana", difficulty: .beginner, recommendedTrimester: .all, relieve: [.back, .neck, .hip], description: "Banana", seconds: 60, state: .completed),
                Pose(id: UUID(), name: "Bound Angle", difficulty: .beginner, recommendedTrimester: .second, relieve: [.hip, .back, .pelvic], description: "Bound Angle", seconds: 60, state: .completed)
            
            ]
            
            let yoga3 = Yoga(id: UUID(), name: "Day 4 - Upper Body", poses: poses, day: .monday, estimationDuration: 5, image: "")
            
            profileNew.histories.append(History(id: UUID(), yogaDone: yoga3, executionDate: Calendar.current.date(byAdding: .day, value: 1, to: Date.now)!, duration: 10, rating: 5))
            if let update = updateUseCase {
                do {
                    try await update.call(profile: profileNew, context: moc!)
                } catch let error {
                    print(error)
                }
                
                if let fetch = fetchUsecase {
                    do{
                        let fetchedProfile = try await fetch.call(context: moc!).last!
                        print(fetchedProfile)
                        XCTAssertEqual(fetchedProfile.histories.count, profileNew.histories.count, "Second Done")
                    } catch let error {
                        print(error)
                    }
                    
                }
            }
        }
    }
}
