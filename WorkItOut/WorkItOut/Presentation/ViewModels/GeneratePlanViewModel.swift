//
//  GeneratePlanViewModel.swift
//  WorkItOut
//
//  Created by Jeremy Raymond on 04/11/23.
//

import Foundation

class GeneratePlanViewModel: ObservableObject {
    @Published var scrollTarget: Int?
    
    func checkCategory(poses: [Pose], category: Category) -> Bool {
        if (poses.first(where: {$0.category == category}) != nil) {
            return true
        }
        return false
    }
}
