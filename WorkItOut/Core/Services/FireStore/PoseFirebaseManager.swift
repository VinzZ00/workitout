//
//  PoseManager.swift
//  WorkItOut
//
//  Created by Jeremy Raymond on 31/10/23.
//

import Foundation

@MainActor
class PoseFirebaseManager: ObservableObject {
    var firestore = FireStoreManager.shared
    @Published var firebasePoses: [RequestYogaPose] = []
    @Published var poses : [Pose] = []
    
    init() {
        self.getFirebasePoses()
        self.addPosetoPoses()
    }
    
    func addPosetoPoses(){
        if poses.isEmpty {
            for firebasePose in firebasePoses {
                var pose = Pose(id: UUID(), name: firebasePose.yogaPose, altName: firebasePose.altName, category: firebasePose.category, difficulty: firebasePose.difficulty, exception: firebasePose.exceptions, recommendedTrimester: firebasePose.recommendedTrimester, relieve: firebasePose.relieves, status: firebasePose.status)
                if let imageURL = firebasePose.imageURL {
                    pose.image = imageURL
                }
                if let videoURL = firebasePose.videoURL {
                    pose.video = videoURL
                }
                
                pose.instructions = YogaNames.poseInstructions[pose.name]!.map {$0.stringValue()}
                
                self.poses.append(pose)
            }
            
            
        }
        
        self.objectWillChange.send()
    }
    
    func getFirebasePoses(){
      firestore.getCollection(collectionName: FirebaseConstant.YogaPoseConstants.collectionName) { querySnapshot in
            querySnapshot.documents.forEach { doc in
                let poseName = doc.data()[FirebaseConstant.YogaPoseConstants.name] as! String
                let altName = doc.data()[FirebaseConstant.YogaPoseConstants.altName] as! String
                
                let categoryString = doc.data()[FirebaseConstant.YogaPoseConstants.category] as! String
                guard let category = Category(rawValue: categoryString) else{
                    return
                }
                
                let difficultyString = doc.data()[FirebaseConstant.YogaPoseConstants.difficulty] as! String
                guard let difficulty = Difficulty(rawValue: difficultyString) else{
                    return
                }
                
                let exceptionRequests = doc.data()[FirebaseConstant.YogaPoseConstants.exceptions] as! String
                let exceptionsArray = exceptionRequests.components(separatedBy: ", ")
                var exceptions : [Exception] = []
                for exception in exceptionsArray {
                    if let value = Exception(rawValue: exception) {
                        exceptions.append(value)
                    }
                }
                
                let recommendedTrimesterRequest = doc.data()[FirebaseConstant.YogaPoseConstants.recommendedTrimester] as! String
                guard let trimester = Trimester(rawValue: recommendedTrimesterRequest) else {
                    return
                }
                
                let relieveRequests = doc.data()[FirebaseConstant.YogaPoseConstants.relieves] as! String
                let relieveArray = relieveRequests.components(separatedBy: ", ")
                var relieves : [Relieve] = []
                for relieve in relieveArray {
                    if let value = Relieve(rawValue: relieve) {
                        relieves.append(value)
                    }
                }
                
                let statusString = doc.data()[FirebaseConstant.YogaPoseConstants.status] as! String
                guard let status = Status(rawValue: statusString) else{
                    return
                }
                
                var requestYogaPose = RequestYogaPose(yogaPose: poseName, altName: altName, category: category, difficulty: difficulty, exceptions: exceptions, recommendedTrimester: trimester, relieves: relieves, status: status)
                if let videoURL = doc.data()[FirebaseConstant.YogaPoseConstants.videoURL] as? String {
                    requestYogaPose.videoURL = videoURL
                }
                if let imageURL = doc.data()[FirebaseConstant.YogaPoseConstants.imageURL] as? String {
                    requestYogaPose.imageURL = imageURL
                }
                
                self.firebasePoses.append(requestYogaPose)
                self.objectWillChange.send()
            }
        }
    }
}
