//
//  GeneratePlanViewModel.swift
//  WorkItOut
//
//  Created by Jeremy Raymond on 04/11/23.
//

import Foundation

class GeneratePlanViewModel: ObservableObject {
    @Published var scrollTarget: Int?
    
    func existingCategories(poses: [Pose]) -> [Category] {
        var categories: [Category] = []
        for pose in poses {
            if !categories.contains(where: {$0 == pose.category}) {
                categories.append(pose.category)
            }
        }
        
        categories.sort(by: {$0.getOrder() < $1.getOrder()})
        return categories
    }
    
    func getPosesByCategory(poses: [Pose], category: Category) -> [Pose] {
        var newPoses: [Pose] = []
        for pose in poses {
            if pose.category == category {
                newPoses.append(pose)
            }
        }
        
        return newPoses
    }
    
    func checkCategory(poses: [Pose], category: Category) -> Bool {
        if (poses.first(where: {$0.category == category}) != nil) {
            return true
        }
        return false
    }
}
