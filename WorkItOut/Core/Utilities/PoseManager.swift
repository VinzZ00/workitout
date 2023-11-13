//
//  PoseManager.swift
//  WorkItOut
//
//  Created by Jeremy Raymond on 07/11/23.
//

import Foundation

struct PoseManager {
    static func checkCategory(poses: [Pose], category: Category) -> Bool {
        if (poses.first(where: {$0.category == category}) != nil) {
            return true
        }
        return false
    }
    
    static func existingCategories(poses: [Pose]) -> [Category] {
        var categories: [Category] = []
        for pose in poses {
            if !categories.contains(where: {$0 == pose.category}) {
                categories.append(pose.category)
            }
        }
        
        categories.sort(by: {$0.getOrder() < $1.getOrder()})
        return categories
    }
    
    static func getPosesByCategory(poses: [Pose], category: Category) -> [Pose] {
        var newPoses: [Pose] = []
        for pose in poses {
            if pose.category == category {
                newPoses.append(pose)
            }
        }
        
        return newPoses
    }
    
    static func createHandMadeYogaPlan(profile: Profile, poses: [Pose]) -> [Relieve : [YogaPlan]] {
        var handMadeYogaPlans: [Relieve : [YogaPlan]] = [:]
        
        for relieve in Relieve.allCases {
            var yogaPlans: [YogaPlan] = []
            for trimester in Trimester.allCases {
                var name = relieve.getString() + " " + trimester.getString()
                yogaPlans.append(createYogaPlan(poses: poses, name: name,trimester: trimester, days: profile.daysAvailable, duration: profile.preferredDuration, exceptions: profile.exceptions, relieves: [relieve]))
            }
            handMadeYogaPlans.updateValue(yogaPlans, forKey: relieve)
        }
        
        print("Handmade work")
        return handMadeYogaPlans
    }
    
    static public func filterPosesByRelieves(poses: [Pose], relieves: [Relieve]) -> [Pose] {
        var filteredPoses: [Pose] = []
        
        if relieves.isEmpty {
            return poses
        }
        
        for pose in poses {
            if pose.relieve.contains(relieves) {
                filteredPoses.append(pose)
            }
        }
        
        return filteredPoses
    }
    
    static private func filterPosesByExceptions(poses: [Pose], exceptions: [Exception]) -> [Pose] {
        var filteredPoses: [Pose] = []
        
        if exceptions.isEmpty {
            return poses
        }
        for pose in poses {
            if !pose.exception.contains(exceptions) {
                filteredPoses.append(pose)
            }
        }
        
        return filteredPoses
    }
    
    static private func probRandomizer(duration: Duration) -> Int {
        let random: Int = Int.random(in: 0...100)
        
        if random <= 70 {
            return duration.getDurationInSeconds()
        }
        else {
            var durations: [Duration] = []
            for dur in Duration.allCases {
                if dur != duration {
                    durations.append(dur)
                }
            }
            return durations.randomElement()!.getDurationInSeconds()
        }
    }
    
    static func changeDuration(duration: Duration, poses: [Pose]) -> [Pose] {
        var newPoses: [Pose] = []
        for pose in poses {
            let seconds: Int = probRandomizer(duration: duration)
            
            newPoses.append(Pose(id: pose.id, name: pose.name, altName: pose.altName, category: pose.category, difficulty: pose.difficulty, exception: pose.exception, recommendedTrimester: pose.recommendedTrimester, relieve: pose.relieve, status: pose.status, image: pose.image, video: pose.video, description: pose.description, instructions: pose.instructions, seconds: seconds, state: pose.state))
        }
        
        return newPoses
    }
    
    static private func poseByCategory(poses: [Pose], category: Category) -> Pose {
        return poses.filter({$0.category == category}).randomElement() ?? Pose(id: UUID())
    }
    
    static private func createPoses(poses: [Pose], duration: Duration, exceptions: [Exception], relieves: [Relieve]) -> [Pose] {
        var poses = filterPosesByExceptions(poses: poses, exceptions: exceptions)
        poses = filterPosesByRelieves(poses: poses, relieves: relieves)
        var newPoses: [Pose] = []
        
        if !poses.isEmpty {
            newPoses.append(poseByCategory(poses: poses, category: .warmUp))
            for _ in 0 ..< Int.random(in: 6...8) {
                var newPose = poseByCategory(poses: poses, category: Category.getMainCategories().randomElement() ?? .standingPose)
                
                var i = 0
                while newPoses.contains(where: {$0.name == newPose.name}) &&
                    (poses.count > newPoses.count) &&
                    !(poses.contains(newPoses)) {
                    newPose = poseByCategory(poses: poses, category: Category.getMainCategories().randomElement() ?? .standingPose)
                    i += 1
                    if i == 100 {
                        print("loop")
                        break
                    }
                }
                
                newPoses.append(newPose)
            }
            newPoses.append(poseByCategory(poses: poses, category: .coolingDown))
        }
        
        newPoses.sort(by: {$0.category.getOrder() > $1.category.getOrder()})
        return newPoses
    }
    
    static private func createYogas(poses: [Pose], days: [Day], duration: Duration, exceptions: [Exception], relieves: [Relieve]) -> [Yoga] {
        var yogas: [Yoga] = []
        
        for day in days {
            yogas.append(Yoga(id: UUID(), name: YogaNames.yogaNames.randomElement()!, poses: createPoses(poses: poses, duration: duration, exceptions: exceptions, relieves: relieves), day: day, estimationDuration: duration.getDurationInMinutes(), image: "ExampleImage.png"))
        }
        
        return yogas
    }
    
    static func createYogaPlan(poses: [Pose], name: String = "Yoga Plan Name", trimester: Trimester, days: [Day], duration: Duration, exceptions: [Exception], relieves: [Relieve]) -> YogaPlan {
        var yogaPlan = YogaPlan(id : UUID(), name: name, trimester: trimester)
        yogaPlan.yogas = self.createYogas(poses: poses, days: days, duration: duration, exceptions: exceptions, relieves: relieves)

        return yogaPlan
    }
}
