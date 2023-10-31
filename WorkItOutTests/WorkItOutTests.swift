//
//  WorkItOutTests.swift
//  WorkItOutTests
//
//  Created by Elvin Sestomi on 30/10/23.
//

import XCTest
import CoreData
@testable import WorkItOut

final class WorkItOutTests: XCTestCase {
    
    var moc : NSManagedObjectContext?
    var addUsecase : AddYogaPlanUsecase?
    var fetchUsecase : FetchYogaPlanUsecase?
    var testRecord : YogaPlan?
    var updateRecord : UpdateYogaPlanUsecase?
    override func setUp()  {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        
        // Adding Yogaplan Usecase
        addUsecase = AddYogaPlanUsecase();
        
        // Fetching YogaPlan Usecase
        fetchUsecase = FetchYogaPlanUsecase();
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        
        moc?.delete(testRecord!.intoNSObject(context: moc!))
        
        moc = nil
        addUsecase = nil
        fetchUsecase = nil
        
        super.tearDown();
    }
    
    func testAddToCoreData() async throws {
        moc = CoreDataManager().container.viewContext
        if let moc = self.moc {
            
            testRecord = YogaPlan()
            testRecord?.id = UUID()
            testRecord?.name = "Testing Plan"
            testRecord?.trimester = .all
            testRecord?.yogas = [
                Yoga(name: "Testing yoga1", poses: [
                    Pose(name: "test pose 1", description: "Descriptiontesting pose", seconds: 10, state: .notCompleted, category: .stand, recommendedTrimester: .all, bodyPartTrained: [.core, .glutes], relieve: [.hippain, .breathing], exception: [.vertigo], difficulty: .beginner).intoNSObject(context: moc) as! PoseNSObject,
                    Pose(name: "test pose 2", description: "Description2testing pose", seconds: 10, state: .notCompleted, category: .stand, recommendedTrimester: .all, bodyPartTrained: [.core, .glutes], relieve: [.hippain, .breathing], exception: [.none], difficulty: .beginner).intoNSObject(context: moc) as! PoseNSObject
                ], day: .monday, estimationDuration: 29, image: "testingImage1").intoNSObject(context: moc) as! YogaNSObject,
                Yoga(name: "Testing yoga2", poses: [
                    Pose(name: "test pose 1", description: "Descriptiontesting pose", seconds: 10, state: .notCompleted, category: .stand, recommendedTrimester: .all, bodyPartTrained: [.core, .glutes], relieve: [.hippain, .breathing], exception: [.vertigo], difficulty: .beginner).intoNSObject(context: moc) as! PoseNSObject,
                    Pose(name: "test pose 2", description: "Description2testing pose", seconds: 10, state: .notCompleted, category: .stand, recommendedTrimester: .all, bodyPartTrained: [.core, .glutes], relieve: [.hippain, .breathing], exception: [.none], difficulty: .beginner).intoNSObject(context: moc) as! PoseNSObject
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
    
//    func testUpdateToCoreData() async throws {
//        
//        updateRecord = UpdateYogaPlanUsecase()
//        
//        try! await testAddToCoreData()
//        
//        let fetchRes = await fetchUsecase!.call(context: moc!)
//        
//        var tempYogaPlan : YogaPlanNSObject!
//        
//        if fetchRes.count > 0 {
//            tempYogaPlan = YogaPlanNSObject(context: moc!)
//            
//            tempYogaPlan.name = "Telah di ubah"
//        } else {
//            fatalError("Yoga plan kosong , test terhenti")
//        }
//        
////        guard let yogaPlan = tempYogaPlan else {
//
////        }
//        
//        
//        await updateRecord?.call(yogaPlan: YogaPlan(id: tempYogaPlan.uuid!, name: tempYogaPlan.name!, yogas: tempYogaPlan.yogas!.allObjects as? [Yoga] ?? [], trimester: Trimester(rawValue: tempYogaPlan.trimester!)!), context: moc!)
//        
//        let refetch = await fetchUsecase?.call(context: moc!)
//        
//        XCTAssertEqual(refetch?.first?.name, "Telah di ubah")
//    }
    
}
