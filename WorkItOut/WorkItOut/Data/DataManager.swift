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
    @Published var profile: Profile?
    var addProfile: AddProfileUseCase = AddProfileUseCase()
    var fetchProfile : FetchProfileUseCase = FetchProfileUseCase()
    @Published var hasNoProfile : Bool = false
    @Published var savedToCoreData : Bool = false
    
    func test() {
        print("Test")
    }
    
    public func loadProfile(moc : NSManagedObjectContext) async {
        let fetchProfile = FetchProfileUseCase()
        
        let fetchRes = await fetchProfile.call(context: moc)
        self.profile = fetchRes.first
        if let profile = self.profile {
            savedToCoreData = true
        }
    }
    
    public func setUpProfile(moc : NSManagedObjectContext, name: String, currentWeek: Int, fitnessLevel: Difficulty, daysAvailable: [Day], timeOfDay: TimeOfDay, preferredDuration: Duration, exceptions: [Exception]) async {
        self.profile = Profile(name: name, currentPregnancyWeek: currentWeek, fitnessLevel: fitnessLevel, daysAvailable: daysAvailable, timeOfDay: timeOfDay, preferredDuration: preferredDuration, exceptions: exceptions)
        
        for trimester in Trimester.allCases {
            self.profile?.plan.append(createYogaPlan(trimester: trimester, days: daysAvailable, duration: preferredDuration, exceptions: exceptions))
        }
        self.objectWillChange.send()
    }
    
    public func createPose() -> Pose {
        
        return pm.poses.randomElement() ?? Pose(id: UUID())
    }
    
    public func filterPoses(exceptions: [Exception]) -> [Pose] {
        let poses = pm.poses
        var filteredPoses: [Pose] = []
        
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
    
    public func createPoses(duration: Duration, exceptions: [Exception]) -> [Pose] {
        var poses = filterPoses(exceptions: exceptions)
        var newPoses: [Pose] = []
        
        newPoses.append(poseByCategory(poses: poses, category: .warmUp))
        for _ in 0 ..< duration.getDurationInMinutes() {
            var newPose = poseByCategory(poses: poses, category: Category.getMainCategories().randomElement() ?? .standingPose)
            if !poses.isEmpty {
                while newPoses.contains(where: {$0.name == newPose.name}) {
                    newPose = poseByCategory(poses: poses, category: Category.getMainCategories().randomElement() ?? .standingPose)
                }
            }
            newPoses.append(newPose)
        }
        newPoses.append(poseByCategory(poses: poses, category: .coolingDown))
        
        newPoses.sort(by: {$0.category.getOrder() > $1.category.getOrder()})
        
        return newPoses
    }
    
    public func createYogas(days: [Day], duration: Duration, exceptions: [Exception]) -> [Yoga] {
        var yogas: [Yoga] = []
        
        for day in days {
            yogas.append(Yoga(id: UUID(), name: "Yoga Name", poses: createPoses(duration: duration, exceptions: exceptions), day: day, estimationDuration: duration.getDurationInMinutes(), image: "ExampleImage.png"))
        }
        
        return yogas
    }
    
    public func createYogaPlan(trimester: Trimester, days: [Day], duration: Duration, exceptions: [Exception]) -> YogaPlan {
        var yogaPlan = YogaPlan(trimester: trimester)
        yogaPlan.yogas = createYogas(days: days, duration: duration, exceptions: exceptions)
        
        return yogaPlan
    }
}

//extension PoseNSObject {
//    func intoPose() -> Pose {
//        return Pose(name: self.name!, description: <#T##String#>, seconds: <#T##Int#>, state: <#T##YogaState#>, position: <#T##Position#>, spineMovement: <#T##SpineMovement#>, recommendedTrimester: <#T##Trimester#>, bodyPartTrained: <#T##[BodyPart]#>, relieve: <#T##[Relieve]#>, difficulty: <#T##Difficulty#>)
//    }
//}
