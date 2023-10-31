//
//  TestFetchFirebase.swift
//  WorkItOut
//
//  Created by Kevin Dallian on 31/10/23.
//

import Foundation

@MainActor
class TestFetchFirebaseViewModel : ObservableObject {
    var useCase = GetYogaPosesUseCase()
    @Published var poses : [RequestYogaPose] = []
    
    func getPoses() async {
        poses = await useCase.call()
        print("Sudah")
    }
}
