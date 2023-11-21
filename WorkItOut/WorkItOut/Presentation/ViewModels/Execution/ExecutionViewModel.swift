//
//  ExecutionViewModel.swift
//  WorkItOut
//
//  Created by Angela Valentine Darmawan on 25/10/23.
//

import AVKit
import CoreData
import Foundation

@MainActor
class ExecutionViewModel: ObservableObject {
    var fetch: FetchProfileUseCase = FetchProfileUseCase()
    @Published var profile: Profile = MockData.mockProfile
    @Published var yogaPlan: YogaPlan!
    @Published var yoga: Yoga = Yoga()
    var poses: [Pose] = []
    @Published var index = 0
    @Published var end = false
    @Published var start = true
    
    // Pregnancy Tips
    @Published var showTips : Bool = false
    @Published var checkBox : Bool = false
    
    // Video and Image Toggler
    @Published var videoURLManager = VideoURLManager()
    @Published var showVideo : Bool = false
    @Published var videoIsLoading : Bool = true
    @Published var desiredVideoURL : URL?
    
    @Published var textSwitch : Bool = false
    @Published var avPlayer : AVPlayer?
    
    var addHist : AddHistoryUseCase = AddHistoryUseCase()
    
    init(yoga: Yoga) {
        self.yoga = yoga
        getPose()
    }
    
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
    
    func getPose() {
        for categori in PoseManager.existingCategories(poses: yoga.poses) {
            for p in PoseManager.getPosesByCategory(poses: yoga.poses, category: categori) {
                poses.append(p)
            }
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
        profile.plan[yogaPlanIndex].yogas[yogaIndex].yogaState = .completed
        
        let poseHistories = createPoseHistories(poses: poses)
        
        let yoga = profile.plan[yogaPlanIndex].yogas[yogaIndex]
        let yogaPlan = profile.plan[yogaPlanIndex]
        
        let yogaHistory = yoga.generateYogaHistory(poseHistory: poseHistories)
        
        let histories = History(id: UUID(), yogaDone: yogaHistory, executionDate: Date.now, duration: profile.preferredDuration.getDurationInMinutes(), rating: 5)
        try await addHist.call(history: histories, context: context)
    }
    
    func loadVideo(videoID : String){
        guard let url = videoURLManager.generateURL(videoID: videoID) else {
            return
        }
        self.desiredVideoURL = url
    }
    
    func accessUserDefault() -> Bool?{
        let defaults = UserDefaults.standard
        return defaults.object(forKey: "skipPregnancyTips") as? Bool
    }
    
    func createPoseHistories(poses: [Pose]) -> [PoseHistory]{
        var array : [PoseHistory] = []
        poses.forEach { pose in
            array.append(PoseHistory(id: pose.id, name: pose.name, altName: pose.altName, category: pose.category, difficulty: pose.difficulty, description: pose.description, seconds: pose.seconds, state: pose.state))
        }
        return array
    }
}
