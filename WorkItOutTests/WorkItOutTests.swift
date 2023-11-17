//
//  WorkitOutTest.swift
//  WorkItOutTests
//
//  Created by Elvin Sestomi on 31/10/23.
//
import CoreData
import XCTest
@testable import Mamaste

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
            let pose = Pose(id: UUID())
            var yoga = Yoga()
            yoga.poses.append(pose)
            var yogaPlanAll = YogaPlan(id: UUID(), name: "Yoga Plan 1", trimester: .all)
            var yogaPlanFirst = YogaPlan(id: UUID(), name: "Yoga Plan 1", trimester: .first)
            var yogaPlanSecond = YogaPlan(id: UUID(), name: "Yoga Plan 1", trimester: .second)
            var yogaPlanThird = YogaPlan(id: UUID(), name: "Yoga Plan 1", trimester: .third)
            yogaPlanAll.yogas.append(yoga)
            yogaPlanFirst.yogas.append(yoga)
            yogaPlanSecond.yogas.append(yoga)
            yogaPlanThird.yogas.append(yoga)
            testRecord = Profile(
                name: "Testing add and fetch",
                currentPregnancyWeek: 2,
                currentRelieveNeeded: [.back, .pelvic],
                fitnessLevel: .beginner,
                daysAvailable: [.monday, .wednesday, .friday],
                timeOfDay: .evening,
                preferredDuration: .tenMinutes,
                plan: [yogaPlanFirst, yogaPlanThird, yogaPlanSecond,yogaPlanAll ],
                histories: [],
                exceptions: []
            )
            
            if let testRecord = testRecord {
                try await addUsecase?.call(profile: testRecord, context: moc)
            }
            
            let fetchRes = try await fetchUsecase?.call(context: moc);
            
            XCTAssertEqual(fetchRes?.last?.name, testRecord!.name, "Done the test")
        }
    }
    
    func testUpdate() async throws {
        if let moc = self.moc {
            let fetchRes = try await fetchUsecase?.call(context: moc)
            if fetchRes?.last != nil {
                var p = fetchRes!.last!
                p.name = "Elvin Sestomi"
                
                try await UpdateProfileUseCase().call(profile: p, context: moc)
                
                let newFetchRequest = try await fetchUsecase?.call(context: moc)
                
                XCTAssertEqual(newFetchRequest!.last!.name, "Elvin Sestomi", "Done")
            }
        }
    }
    
    func testUpdateAddingException() async throws {
        let fetchRes = try await fetchUsecase?.call(context: moc!)
        
        var newProfile = fetchRes![fetchRes!.count - 1]
        newProfile.exceptions.append(Exception.vertigo)
        
        try await UpdateProfileUseCase().call(profile: newProfile, context: moc!)
        
        let afterUpdate = try await fetchUsecase?.call(context: moc!)
        
        XCTAssertEqual(afterUpdate!.last!.exceptions.map{$0.rawValue}.joined(separator: ", "), newProfile.exceptions.map{$0.rawValue}.joined(separator: ", "), "Done the update test")
        
    }

}
