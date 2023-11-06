//
//  WorkitOutTest.swift
//  WorkItOutTests
//
//  Created by Elvin Sestomi on 31/10/23.
//
import CoreData
import XCTest
@testable import WorkItOut

final class WorkitOutTests: XCTestCase {

    var moc : NSManagedObjectContext?
    var addUsecase : AddProfileUseCase?
    var fetchUsecase : FetchProfileUseCase?
    var testRecord : Profile?
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        
        moc = CoreDataManager().container.viewContext
        addUsecase = AddProfileUseCase()
        fetchUsecase = FetchProfileUseCase()
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        moc = nil
        addUsecase = nil
        fetchUsecase = nil
        
        try super.tearDownWithError()
    }

    func testAddAndFetchCoreData() async throws {
        if let moc = self.moc {
            
            
            testRecord = Profile(
                name: "Testing add and fetch",
                currentPregnancyWeek: 2,
                currentRelieveNeeded: [.backpain, .breathing],
                fitnessLevel: .beginner,
                daysAvailable: [.monday, .wednesday, .friday],
                timeOfDay: .evening,
                preferredDuration: .fiveteenMinutes,
                plan: [
                    YogaPlan(id: UUID(), name: "Plan 1", yogas: [
                        Yoga(id: UUID(), name: "Yoga 1", poses: [
                            Pose(id: UUID(), name: "Pose1", description: "Desc 1", seconds: 12, state: .completed, position: .armBalance, spineMovement: .backBend, recommendedTrimester: .all, bodyPartTrained: [.arms, .back], relieve: [.backpain], exception: [.vertigo], difficulty: .beginner)
                        ], day: .monday, estimationDuration: 12, image: "Image 1")
                    ], trimester: .all)
                ],
                histories: [],
                exceptions: []
            );

            
            if let testRecord = testRecord {
                await addUsecase?.call(profile: testRecord, context: moc)
            }
            
            let fetchRes = await fetchUsecase?.call(context: moc);
            
            XCTAssertEqual(fetchRes?.first?.name, testRecord!.name, "Done the test")
        }
    }
    
    func testUpdateAddingException() async throws {
        var fetchRes = await fetchUsecase?.call(context: moc!)
        
        var newProfile = fetchRes![fetchRes!.count - 1]
        newProfile.exceptions.append(Exception.vertigo)
        
        await UpdateProfileUseCase().call(profile: newProfile, context: moc!)
        
        var afterUpdate = await fetchUsecase?.call(context: moc!)
        
        XCTAssertEqual(afterUpdate!.last!.exceptions.map{$0.rawValue}.joined(separator: ", "), newProfile.exceptions.map{$0.rawValue}.joined(separator: ", "), "Done the update test")
        
    }

}
