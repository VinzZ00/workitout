//
//  ProfileTests.swift
//  WorkItOutTests
//
//  Created by Kevin Dallian on 01/11/23.
//

import XCTest
@testable import WorkItOut

final class ProfileTests: XCTestCase {
    var profileViewModel = ProfileViewModel()
    func testConvertDaytoStrings(){
        let days : [Day] = [.monday, .tuesday, .sunday]
        
        let strings = profileViewModel.convertToString(days: days)
        XCTAssertEqual(strings, "Mon, Tue, Sun")
    }
    
    func testConvertRelievestoStrings(){
        let relieves : [Relieve] = [.backpain, .breathing, .hippain]
        let strings = profileViewModel.convertToStrings(relieves: relieves)
        
        XCTAssertEqual(strings, "Back Pain, Breathing, Hip Pain")
    }
    
    func testConvertGetTrimester(){
        let currentPregnantWeek = 20
        let strings = profileViewModel.convertToStrings(currentPregnancyWeek: currentPregnantWeek)
        
        XCTAssertEqual(strings, "Week 20 (Trimester 2)")
    }
}
