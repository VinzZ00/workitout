//
//  PoseManager.swift
//  WorkItOut
//
//  Created by Jeremy Raymond on 31/10/23.
//

import Foundation

@MainActor
class PoseManager: ObservableObject {
    var firestore = FireStoreManager.shared
    @Published var firebasePoses: [RequestYogaPose] = []
    @Published var poses : [Pose] = []
    
    init() {
        self.getFirebasePoses()
        self.addPosetoPoses()
    }
    
    func addPosetoPoses(){
        if poses.isEmpty {
            for pose in firebasePoses {
                self.poses.append(Pose(id: UUID(), name: pose.yogaPose, altName: pose.altName, category: pose.category, difficulty: pose.difficulty, exception: pose.exceptions, recommendedTrimester: pose.recommendedTrimester, relieve: pose.relieves, status: pose.status))
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
                
                let requestYogaPose = RequestYogaPose(yogaPose: poseName, altName: altName, category: category, difficulty: difficulty, exceptions: exceptions, recommendedTrimester: trimester, relieves: relieves, status: status)
                
                self.firebasePoses.append(requestYogaPose)
                self.objectWillChange.send()
            }
        }
    }
}
