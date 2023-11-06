//
//  WorkitOutTest.swift
//  WorkItOutTests
//
//  Created by Elvin Sestomi on 31/10/23.
//
import CoreData
import XCTest
@testable import WorkItOut

final class WorkitOutTest: XCTestCase {

    var moc : NSManagedObjectContext?
    var addUsecase : AddYogaPlanUseCase?
    var fetchUsecase : FetchYogaPlanUsecase?
    var testRecord : YogaPlan?
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        
        moc = CoreDataManager().container.viewContext
        addUsecase = AddYogaPlanUseCase()
        fetchUsecase = FetchYogaPlanUsecase()
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        moc = nil
        addUsecase = nil
        fetchUsecase = nil
        
        try super.tearDownWithError()
    }

    func testExample() async throws {
        if let moc = self.moc {
            
            testRecord = YogaPlan()
            testRecord?.id = UUID()
            testRecord?.name = "Testing Plan"
            testRecord?.trimester = .all
            testRecord?.yogas = [
                Yoga(name: "Testing yoga1", poses: [
                    Pose(name: "test pose 1", description: "Descriptiontesting pose", seconds: 10, state: .notCompleted, position: .stand, spineMovement: .backBend, recommendedTrimester: .all, bodyPartTrained: [.core, .glutes], relieve: [.hippain, .breathing], exception: [.vertigo], difficulty: .beginner).intoNSObject(context: moc) as! PoseNSObject,
                    Pose(name: "test pose 2", description: "Description2testing pose", seconds: 10, state: .notCompleted, position: .stand, spineMovement: .backBend, recommendedTrimester: .all, bodyPartTrained: [.core, .glutes], relieve: [.hippain, .breathing], exception: [.none], difficulty: .beginner).intoNSObject(context: moc) as! PoseNSObject
                ], day: .monday, estimationDuration: 29, image: "testingImage1").intoNSObject(context: moc) as! YogaNSObject,
                Yoga(name: "Testing yoga2", poses: [
                    Pose(name: "test pose 1", description: "Descriptiontesting pose", seconds: 10, state: .notCompleted, position: .stand, spineMovement: .backBend, recommendedTrimester: .all, bodyPartTrained: [.core, .glutes], relieve: [.hippain, .breathing], exception: [.vertigo], difficulty: .beginner).intoNSObject(context: moc) as! PoseNSObject,
                    Pose(name: "test pose 2", description: "Description2testing pose", seconds: 10, state: .notCompleted, position: .stand, spineMovement: .backBend,  recommendedTrimester: .all, bodyPartTrained: [.core, .glutes], relieve: [.hippain, .breathing], exception: [.none], difficulty: .beginner).intoNSObject(context: moc) as! PoseNSObject
                ], day: .monday, estimationDuration: 29, image: "testingImage2").intoNSObject(context: moc) as! YogaNSObject
            ]
            
            var moc2 = CoreDataManager().container.viewContext
            
            if let testRecord = testRecord {
                await addUsecase?.call(yogaPlan: testRecord, context: moc)
            }
            
            let fetchRes = await fetchUsecase?.call(context: moc2);
            
            XCTAssertEqual(fetchRes?.first?.name, testRecord!.name, "Done the test")
        }
    }

}
