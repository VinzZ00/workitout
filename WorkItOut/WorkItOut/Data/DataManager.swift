//
//  DataManager.swift
//  WorkItOut
//
//  Created by Jeremy Raymond on 31/10/23.
//

import Foundation
import CoreData

@MainActor
class DataManager: ObservableObject {
    @Published var pm: PoseManager = PoseManager()
    @Published var profile: Profile = Profile()
    var addProfile: AddProfileUseCase = AddProfileUseCase()
    
    var handMadeYogaPlan: [Relieve : [YogaPlan]] = [:]
    
    public func loadProfile(moc : NSManagedObjectContext) async {
        let fetchProfile = FetchProfileUseCase()
        
        let fetchRes = await fetchProfile.call(context: moc)
        DispatchQueue.main.async {
            self.profile = fetchRes.first!
        }
    }
    
    public func setUpProfile(moc: NSManagedObjectContext, profile: Profile) async {
        self.profile = profile
        
        for trimester in Trimester.allCases {
            self.profile.plan.append(createYogaPlan(trimester: trimester, days: profile.daysAvailable, duration: profile.preferredDuration, exceptions: profile.exceptions, relieves: []))
        }
        
        self.handMadeYogaPlan = self.handMadeYogaPlanPlaceholder()
        print("Set up profile work")
    }
    
    public func setUpProfile(moc : NSManagedObjectContext, name: String, currentWeek: Int, fitnessLevel: Difficulty, daysAvailable: [Day], timeOfDay: TimeOfDay, preferredDuration: Duration, exceptions: [Exception]) async {
        self.profile = Profile(name: name, currentPregnancyWeek: currentWeek, fitnessLevel: fitnessLevel, daysAvailable: daysAvailable, timeOfDay: timeOfDay, preferredDuration: preferredDuration, exceptions: exceptions)
        
        for trimester in Trimester.allCases {
            profile.plan.append(createYogaPlan(trimester: trimester, days: daysAvailable, duration: preferredDuration, exceptions: exceptions, relieves: []))
        }
        
        self.handMadeYogaPlan = self.handMadeYogaPlanPlaceholder()
    }
    
    func handMadeYogaPlanPlaceholder() -> [Relieve : [YogaPlan]] {
        var handMadeYogaPlans: [Relieve : [YogaPlan]] = [:]
        
        for relieve in Relieve.allCases {
            var yogaPlans: [YogaPlan] = []
            for trimester in Trimester.allCases {
                var name = relieve.getString() + " " + trimester.getString()
                yogaPlans.append(createYogaPlan(name: name,trimester: trimester, days: profile.daysAvailable, duration: profile.preferredDuration, exceptions: profile.exceptions, relieves: [relieve]))
            }
            handMadeYogaPlans.updateValue(yogaPlans, forKey: relieve)
        }
        
        print("Handmade work")
        return handMadeYogaPlans
    }
    
    public func filterPosesByRelieves(poses: [Pose], relieves: [Relieve]) -> [Pose] {
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
    
    public func filterPosesByExceptions(poses: [Pose], exceptions: [Exception]) -> [Pose] {
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
    
    public func poseByCategory(poses: [Pose], category: Category) -> Pose {
        return poses.filter({$0.category == category}).randomElement() ?? Pose(id: UUID())
    }
    
    public func createPoses(duration: Duration, exceptions: [Exception], relieves: [Relieve]) -> [Pose] {
        var poses = filterPosesByExceptions(poses: pm.poses, exceptions: exceptions)
        poses = filterPosesByRelieves(poses: poses, relieves: relieves)
        var newPoses: [Pose] = []
        
        newPoses.append(poseByCategory(poses: poses, category: .warmUp))
        for _ in 0 ..< duration.getDurationInMinutes() {
            var newPose = poseByCategory(poses: poses, category: Category.getMainCategories().randomElement() ?? .standingPose)
            if !poses.isEmpty {
                var i = 0
                while newPoses.contains(where: {$0.name == newPose.name}) && (poses.count > newPoses.count) {
                    i += 1
                    newPose = poseByCategory(poses: poses, category: Category.getMainCategories().randomElement() ?? .standingPose)
                    print(i)
                    if i == 100 {
                        print("loop")
                    }
                }
                
            }
            newPoses.append(newPose)
        }
        newPoses.append(poseByCategory(poses: poses, category: .coolingDown))
        
        newPoses.sort(by: {$0.category.getOrder() > $1.category.getOrder()})
        
        print("Pose work")
        return newPoses
    }
    
    public func createYogas(days: [Day], duration: Duration, exceptions: [Exception], relieves: [Relieve]) -> [Yoga] {
        var yogas: [Yoga] = []
        
        for day in days {
            yogas.append(Yoga(id: UUID(), name: "Yoga Name", poses: createPoses(duration: duration, exceptions: exceptions, relieves: relieves), day: day, estimationDuration: duration.getDurationInMinutes(), image: "ExampleImage.png"))
        }
        
        print("yoga work")
        return yogas
    }
    
    public func createYogaPlan(name: String = "Yoga Plan Name", trimester: Trimester, days: [Day], duration: Duration, exceptions: [Exception], relieves: [Relieve]) -> YogaPlan {
        var yogaPlan = YogaPlan(name: name, trimester: trimester)
        yogaPlan.yogas = createYogas(days: days, duration: duration, exceptions: exceptions, relieves: relieves)
        
        print("Yoga plan work")
        return yogaPlan
    }
}
