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
    
    public func setUpProfile(moc : NSManagedObjectContext, name: String, currentWeek: Int, currentRelieveNeeded: [Relieve], fitnessLevel: Difficulty, daysAvailable: [Day], timeOfDay: TimeOfDay, preferredDuration: Duration, plan: [YogaPlan], histories: [History]) async {
        self.profile = createProfile(name: name, currentWeek: currentWeek, currentRelieveNeeded: currentRelieveNeeded, fitnessLevel: fitnessLevel, daysAvailable: daysAvailable, timeOfDay: timeOfDay, preferredDuration: preferredDuration, plan: plan, histories: histories)
        
        for trimester in Trimester.allCases {
            profile.plan.append(createYogaPlan(trimester: trimester))
        }
    }
    
    public func createProfile(name: String, currentWeek: Int, currentRelieveNeeded: [Relieve], fitnessLevel: Difficulty, daysAvailable: [Day], timeOfDay: TimeOfDay, preferredDuration: Duration, plan: [YogaPlan], histories: [History]) -> Profile {
        return Profile(name: name, currentPregnancyWeek: currentWeek, currentRelieveNeeded: currentRelieveNeeded, fitnessLevel: fitnessLevel, daysAvailable: daysAvailable, timeOfDay: timeOfDay, preferredDuration: preferredDuration, plan: plan, histories: histories)
    }
    
    public func createPose() -> Pose {
        let testPose = Pose(id: UUID(), name: "Test Name", description: "Test Description", seconds: 10, state: .notCompleted, position: .armBalance, spineMovement: .backBend, recommendedTrimester: .first, bodyPartTrained: [], relieve: [], difficulty: .beginner)
        
        return pm.poses.randomElement() ?? testPose
    }
    
    public func createYogas() -> [Yoga] {
        var yogas: [Yoga] = []
        let days = profile.daysAvailable
        
//        var testPose = Pose(id: UUID(), name: "Test Name", description: "Test Description", seconds: 10, state: .notCompleted, position: .armBalance, spineMovement: .backBend, recommendedTrimester: .first, bodyPartTrained: [], relieve: [], difficulty: .beginner)
        
        for day in days {
            yogas.append(Yoga(id: UUID(), name: "Yoga Name", poses: [createPose(), createPose(), createPose()], day: day, estimationDuration: 20, image: "ExampleImage.png"))
        }
        
        return yogas
    }
    
    public func createYogaPlan(trimester: Trimester) -> YogaPlan {
        var yogaPlan: YogaPlan = YogaPlan(id: UUID(), name: "Yoga Plan Name", yogas: createYogas(), trimester: trimester)
        return yogaPlan
    }
}

//extension PoseNSObject {
//    func intoPose() -> Pose {
//        return Pose(name: self.name!, description: <#T##String#>, seconds: <#T##Int#>, state: <#T##YogaState#>, position: <#T##Position#>, spineMovement: <#T##SpineMovement#>, recommendedTrimester: <#T##Trimester#>, bodyPartTrained: <#T##[BodyPart]#>, relieve: <#T##[Relieve]#>, difficulty: <#T##Difficulty#>)
//    }
//}
