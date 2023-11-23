//
//  HittingAPITesting.swift
//  MamasteTests
//
//  Created by Elvin Sestomi on 21/11/23.
//

import XCTest
@testable import Mamaste

final class HittingAPITesting: XCTestCase {

    var localizedInstruction : LocalizePoseInstructionUseCase?
    var p : Pose?
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        
        continueAfterFailure = false
        
        self.p = Pose(id: UUID(), name: "Banana");
        
        localizedInstruction = LocalizePoseInstructionUseCase()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        localizedInstruction = nil;
        
        try super.tearDownWithError()
    }

    func testExample() async throws {
        
        if let fetchLocalizedInstruction = localizedInstruction {
            if let pose = p {
                var poseInstruction = try await fetchLocalizedInstruction.call(poses: [pose]).first?.instructions;
                var x = 1;
                poseInstruction?.forEach{
                    ins in
                    print("pose Instruction \(x+=1) : \(ins)")
                }
            }
        }
        
    }

}
