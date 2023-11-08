//
//  ExecutionViewModel.swift
//  WorkItOut
//
//  Created by Angela Valentine Darmawan on 25/10/23.
//

import CoreData
import Foundation

@MainActor
class ExecutionViewModel: ObservableObject {
    var fetch: FetchProfileUseCase = FetchProfileUseCase()
    var update: UpdateProfileUseCase = UpdateProfileUseCase()
    @Published var profile: Profile = MockData.mockProfile
    @Published var yogaPlan: YogaPlan = YogaPlan()
    @Published var yoga: Yoga = Yoga()
    @Published var poses: [Pose] = []
    @Published var index = 0
    @Published var end = false
    @Published var start = true
    
    
    init(yoga: Yoga) {
        self.yoga = yoga
        getPose()
    }
    
//    func addprofile(moc: NSManagedObjectContext) async throws {
//         self.profile = try await fetch.call(context: moc).last!
//    }
    
    func getTrimester() -> Int{
        if  1...13 ~= profile.currentPregnancyWeek {
            return 1
        }else if 14...27 ~= profile.currentPregnancyWeek {
            return 2
        }else {
            return 3
        }
    }
    
    func getYogaPlanIndex() -> Int {
        return profile.plan.firstIndex(where: {$0.trimester.getInt() == getTrimester()}) ?? -1
    }
    
    func getYoga() {
        let date = 5 // ganti dengan hari ini
        
        for yoga in yogaPlan.yogas {
            if (yoga.day.getInt() == date) {
                self.yoga = yoga
            }
        }
    }
    
    func getPose() {
        for p in yoga.poses{
            poses.append(p)
        }
    }
    
    func nextPose(skipped : Bool){
        poseChecker(pose: poses[index], skipped: skipped)
        if index + 1 < poses.count {
            index += 1
            self.objectWillChange.send()
        }else{
            end = true
            self.objectWillChange.send()
        }
    }
    
    func previousPose(){
        if index > 0 {
            index -= 1
            self.objectWillChange.send()
        }else{
            end = true
            self.objectWillChange.send()
        }
    }
    
    func poseChecker(pose: Pose, skipped: Bool){
        guard let poseIndex = poses.firstIndex(of: pose) else {
            return
        }
        if skipped {
            poses[poseIndex].state = .skipped
        } else {
            poses[poseIndex].state = .completed
        }
    }
    
    func savePoses(context: NSManagedObjectContext) async throws {
        profile = try await fetch.call(context: context).last!
        
        let yogaPlanIndex = getYogaPlanIndex()
        guard let yogaIndex = profile.plan[yogaPlanIndex].yogas.firstIndex(of: yoga) else {
            return
        }
        profile.plan[yogaPlanIndex].yogas[yogaIndex].poses = poses
        let history = History(id: UUID(), yogaDone: profile.plan[yogaPlanIndex].yogas[yogaIndex], executionDate: Date.now, duration: 5, rating: 5)
        profile.histories.append(history)
        try await self.update.call(profile: profile, context: context)
    }
}
