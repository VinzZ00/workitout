//
//  DataManager.swift
//  WorkItOut
//
//  Created by Jeremy Raymond on 31/10/23.
//

import Foundation
import CoreData
//import CoreData
@MainActor
class DataManager: ObservableObject {
    @Published var pm: PoseManager = PoseManager()
    @Published var profile: Profile = Profile()
    var addProfile: AddProfileUseCase = AddProfileUseCase()
    
//    public func async saveProfile(Profile: profile) {
//        await addProfile.call(profile: profile, context: moc)
//    }
    
    func test() {
        print("Test")
    }
    
    public func loadProfile(moc : NSManagedObjectContext) async {
        let fetchProfile = FetchProfileUseCase()
        
        let fetchRes = await fetchProfile.call(context: moc)
        DispatchQueue.main.async {
            self.profile = fetchRes.first!
        }
        
    }
    
    public func setUpProfile(moc : NSManagedObjectContext, name: String, currentWeek: Int, fitnessLevel: Difficulty, daysAvailable: [Day], timeOfDay: TimeOfDay, preferredDuration: Duration, exceptions: [Exception]) async {
        self.profile = Profile(name: name, currentPregnancyWeek: currentWeek, fitnessLevel: fitnessLevel, daysAvailable: daysAvailable, timeOfDay: timeOfDay, preferredDuration: preferredDuration, exceptions: exceptions)
        
        for trimester in Trimester.allCases {
            profile.plan.append(createYogaPlan(trimester: trimester))
        }
        
        
//        if profile.plan.contains(where: { ygp in
//            !ygp.yogas.isEmpty
//        }) {
//            await addProfile.call(profile: profile, context: moc)
//        }
//        
//        
//        
//        let fetchProfile = FetchProfileUseCase()
//        
//        let fetchRes = await fetchProfile.call(context: moc)
//        
//        self.profile = fetchRes.first!
//        
//        print(fetchRes.first?.name)
    }
    
    //Pose creation logic will go here
    public func createPose() -> Pose {
        
        return pm.poses.randomElement() ?? Pose(id: UUID())
    }
    
    public func filterPoses() -> [Pose] {
        let poses = pm.poses
        var filteredPoses: [Pose] = []
        
        for pose in poses {
            if !pose.exception.contains(profile.exceptions) {
                filteredPoses.append(pose)
            }
        }
        
        return filteredPoses
    }
    
    public func poseByCategory(poses: [Pose], category: Category) -> Pose {
        return poses.filter({$0.category == category}).randomElement() ?? Pose(id: UUID())
    }
    
    public func createPoses() -> [Pose] {
        var poses = filterPoses()
        var newPoses: [Pose] = []
        
        newPoses.append(poseByCategory(poses: poses, category: .warmUp))
        for _ in 0..<profile.preferredDuration.getDurationInMinutes()/2 {
            newPoses.append(poseByCategory(poses: poses, category: Category.getMainCategories().randomElement() ?? .standingPose))
        }
        newPoses.append(poseByCategory(poses: poses, category: .coolingDown))
        
        return newPoses
    }
    
    public func createYogas() -> [Yoga] {
        var yogas: [Yoga] = []
        let days = profile.daysAvailable
        
        for day in days {
            yogas.append(Yoga(id: UUID(), name: "Yoga Name", poses: createPoses(), day: day, estimationDuration: profile.preferredDuration.getDurationInMinutes(), image: "ExampleImage.png"))
        }
        
        return yogas
    }
    
    public func createYogaPlan(trimester: Trimester) -> YogaPlan {
        var yogaPlan = YogaPlan(trimester: trimester)
        yogaPlan.yogas = createYogas()
        
        return yogaPlan
    }
}

//extension PoseNSObject {
//    func intoPose() -> Pose {
//        return Pose(name: self.name!, description: <#T##String#>, seconds: <#T##Int#>, state: <#T##YogaState#>, position: <#T##Position#>, spineMovement: <#T##SpineMovement#>, recommendedTrimester: <#T##Trimester#>, bodyPartTrained: <#T##[BodyPart]#>, relieve: <#T##[Relieve]#>, difficulty: <#T##Difficulty#>)
//    }
//}
