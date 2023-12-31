//
//  ProfileTests.swift
//  WorkItOutTests
//
//  Created by Kevin Dallian on 01/11/23.
//

import XCTest
@testable import Mamaste

final class ProfileTests: XCTestCase {
    var profileViewModel : ProfileViewModel?
    
    @MainActor override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        profileViewModel = ProfileViewModel()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        try super.tearDownWithError()
        profileViewModel = nil
    }
    
    @MainActor func testConvertDaytoStrings(){
        let days : [Day] = [.monday, .tuesday, .sunday]
        if let pvm = profileViewModel {
            let strings = pvm.convertToString(days: days)
            
            XCTAssertEqual(strings, "Mon, Tue, Sun")
        }
    }
    
    @MainActor func testConvertExceptionstoStrings(){
        let exceptions : [Exception] = [.abdominalSurgery, .diastasisRecti]
        if let pvm = profileViewModel {
            let strings = pvm.convertToStrings(exceptions: exceptions)
            
            XCTAssertEqual(strings, "Abdominal Surgery, Diastatis Recti")
        }
        
    }
    
    @MainActor func testConvertGetTrimester(){
        let currentPregnantWeek = 20
        if let pvm = profileViewModel {
            let strings = pvm.convertToStrings(currentPregnancyWeek: currentPregnantWeek)
            
            XCTAssertEqual(strings, "Week 20 (Trimester 2)")
        }
    }
}
