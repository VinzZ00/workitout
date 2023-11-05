//
//  HandmadeYogaPlans.swift
//  WorkItOut
//
//  Created by Jeremy Raymond on 05/11/23.
//

import Foundation

@MainActor
class HandmadeYogaPlans {
//    static var dm: DataManager = DataManager()
    static var yogaPlans: [YogaPlan] = loadYogaPlan()
    static var pm = PoseManager()
    
    static func loadYogaPlan() -> [YogaPlan] {
        var yogaPlans: [YogaPlan] = []
        
        for _ in 0...3 {
            print("test")
            yogaPlans.append(createYogaPlan(trimester: Trimester.allCases.randomElement()!, days: [.friday], duration: .tenMinutes, exceptions: [.abdominalSurgery]))
        }
        
//        for relieve in Relieve.allCases { relieve
//            yogaPlans.append(dm.createYogaPlan(trimester: Trimester.allCases.randomElement()!, days: [.friday], duration: .tenMinutes))
//        }
        
        return yogaPlans
    }
    
    static func filterPoses(exceptions: [Exception]) -> [Pose] {
//        pm.addPosetoPoses()
        let poses = pm.poses
        var filteredPoses: [Pose] = []
        
        if poses.isEmpty {
            print("Pose is empty")
        }
        
        for pose in poses {
            if !pose.exception.contains(exceptions) {
                filteredPoses.append(pose)
            }
        }
        
        return filteredPoses
    }
    
    static func poseByCategory(poses: [Pose], category: Category) -> Pose {
        return poses.filter({$0.category == category}).randomElement() ?? Pose(id: UUID())
    }
    
    static func createPoses(duration: Duration, exceptions: [Exception]) -> [Pose] {
        var poses = filterPoses(exceptions: exceptions)
        var newPoses: [Pose] = []
        
        
        
        newPoses.append(poseByCategory(poses: poses, category: .warmUp))
        for _ in 0 ..< duration.getDurationInMinutes() {
            var newPose = poseByCategory(poses: poses, category: Category.getMainCategories().randomElement() ?? .standingPose)
            
            while newPoses.contains(where: {$0.name == newPose.name}) {
                newPose = poseByCategory(poses: poses, category: Category.getMainCategories().randomElement() ?? .standingPose)
            }
            
            newPoses.append(newPose)
        }
        newPoses.append(poseByCategory(poses: poses, category: .coolingDown))
        
        newPoses.sort(by: {$0.category.getOrder() > $1.category.getOrder()})
        
        return newPoses
    }
    
    static func createYogas(days: [Day], duration: Duration, exceptions: [Exception]) -> [Yoga] {
        var yogas: [Yoga] = []
        
        for day in days {
            yogas.append(Yoga(id: UUID(), name: "Yoga Name", poses: createPoses(duration: duration, exceptions: exceptions), day: day, estimationDuration: duration.getDurationInMinutes(), image: "ExampleImage.png"))
        }
        
        return yogas
    }
    
    static func createYogaPlan(trimester: Trimester, days: [Day], duration: Duration, exceptions: [Exception]) -> YogaPlan {
        var yogaPlan = YogaPlan(trimester: trimester)
        yogaPlan.yogas = createYogas(days: days, duration: duration, exceptions: exceptions)
        
        return yogaPlan
    }
}
