//
//  ExecutionViewModel.swift
//  WorkItOut
//
//  Created by Angela Valentine Darmawan on 25/10/23.
//

import CoreData
import Foundation

class ExecutionViewModel: ObservableObject {
    var fetch: FetchProfileUseCase = FetchProfileUseCase()
    var update: UpdateProfileUseCase = UpdateProfileUseCase()
    @Published var trimester: Int = 0
    @Published var profile: Profile = MockData.mockProfile
    @Published var yogaPlan: YogaPlan = YogaPlan()
    @Published var yoga: Yoga = Yoga()
    @Published var poses: [Pose] = []
    @Published var index = 0
    @Published var end = false
    @Published var start = true
    
    
    init() {
        addprofile()
        getTrimester()
        getYogaPlan()
        getYoga()
        getPose()
    }
    
    func addprofile(){
        // ganti ke load core data
        profile = MockData.mockProfile
    }
    
    func getTrimester(){
        if  1...13 ~= profile.currentPregnancyWeek {
            trimester = 1
        }else if 14...27 ~= profile.currentPregnancyWeek {
            trimester = 2
        }else {
            trimester = 3
        }
    }
    
    func getYogaPlan() {
        for plan in profile.plan{
            if plan.trimester.getInt() == trimester{
                yogaPlan = plan
            }
        }
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
    
    func savePoses(context: NSManagedObjectContext) async{
        guard let yogaPlanIndex = profile.plan.firstIndex(where: {$0.id == yogaPlan.id}) else {
            return
        }
        guard let yogaIndex = profile.plan[yogaPlanIndex].yogas.firstIndex(of: yoga) else {
            return
        }
        
        profile.plan[yogaPlanIndex].yogas[yogaIndex].poses = poses
        let history = History(id: UUID(), yogaDone: profile.plan[yogaPlanIndex].yogas[yogaIndex], executionDate: Date.now, duration: 5, rating: 5)
        profile.histories.append(history)
        // update profile di core data
//        await self.update.call(profile: profile, context: context)
    }
}
