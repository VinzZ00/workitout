//
//  HistoryTests.swift
//  WorkItOutTests
//
//  Created by Kevin Dallian on 03/11/23.
//

import XCTest
import CoreData
@testable import WorkItOut

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
            Pose(id: UUID(), name: "Banana", description: "Banana", seconds: 60, state: .completed, position: .supine, spineMovement: .lateralBend, recommendedTrimester: .all, bodyPartTrained: [.back, .chest, .core], relieve: [.backpain, .neckcramp, .hippain], difficulty: .beginner),
            Pose(id: UUID(), name: "Bound Angle", description: "Bound Angle", seconds: 60, state: .completed, position: .seated, spineMovement: .neutral, recommendedTrimester: .second, bodyPartTrained: [.shoulders, .legs], relieve: [.hippain, .backpain, .pelvicflexibility], difficulty: .beginner)
        
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
    
    func testSaveHistory() async {
        let poses = [
            Pose(id: UUID(), name: "Banana", description: "Banana", seconds: 60, state: .completed, position: .supine, spineMovement: .lateralBend, recommendedTrimester: .all, bodyPartTrained: [.back, .chest, .core], relieve: [.backpain, .neckcramp, .hippain], difficulty: .beginner),
            Pose(id: UUID(), name: "Bound Angle", description: "Bound Angle", seconds: 60, state: .completed, position: .seated, spineMovement: .neutral, recommendedTrimester: .second, bodyPartTrained: [.shoulders, .legs], relieve: [.hippain, .backpain, .pelvicflexibility], difficulty: .beginner)
        
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
        
        if let add = addUsecase {
            var profile = Profile(name: "", currentPregnancyWeek: 4, currentRelieveNeeded: [], fitnessLevel: .beginner, daysAvailable: [.monday, .wednesday, .friday], timeOfDay: .morning, preferredDuration: .sixtyMinutes, plan: [], histories: [])
            await add.call(profile: profile, context: moc!)
            
            profile.histories.append(contentsOf: histories)
            if let update = updateUseCase {
                await update.call(profile: profile, context: moc!)
                if let fetch = fetchUsecase {
                    var fetchedProfile = await fetch.call(context: moc!).first!
                    XCTAssertEqual(fetchedProfile.histories.count, profile.histories.count, "Done")
                }
            }
        }
    }

}
