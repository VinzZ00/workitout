//
//  TestFetchFirebase.swift
//  WorkItOut
//
//  Created by Kevin Dallian on 31/10/23.
//

import Foundation

@MainActor
class TestFetchFirebaseViewModel : ObservableObject {
//    var useCase = GetYogaPosesUseCase()
    var firestore = FireStoreManager.shared
    @Published var poses : [RequestYogaPose] = []
    
    func getPoses(){
        firestore.getCollection(collectionName: FirebaseConstant.YogaPoseConstants.collectionName) { querySnapshot in
            querySnapshot.documents.forEach { doc in
                let poseName = doc.data()[FirebaseConstant.YogaPoseConstants.name] as! String
                let altName = doc.data()[FirebaseConstant.YogaPoseConstants.altName] as! String
                
                let bodyPartRequests = doc.data()[FirebaseConstant.YogaPoseConstants.bodyPartTrained] as! String
                let bodyParts = bodyPartRequests.components(separatedBy: ",")
                let bodyPartsEnum = bodyParts.map({BodyPart(rawValue: $0) ?? .arms})
                
                let difficultyString = doc.data()[FirebaseConstant.YogaPoseConstants.difficulty] as! String
                guard let difficulty = Difficulty(rawValue: difficultyString) else{
                    return
                }
                
                let exceptionRequests = doc.data()[FirebaseConstant.YogaPoseConstants.exceptions] as! String
                let exceptions = exceptionRequests.components(separatedBy: ",")
                
                let positionRequest = doc.data()[FirebaseConstant.YogaPoseConstants.position] as! String
                guard let position = Position(rawValue: positionRequest) else{
                    return
                }
                
                let recommendedTrimesterRequest = doc.data()[FirebaseConstant.YogaPoseConstants.recommendedTrimester] as! String
                guard let trimester = Trimester(rawValue: recommendedTrimesterRequest) else {
                    return
                }
                
                let relieveRequests = doc.data()[FirebaseConstant.YogaPoseConstants.relieves] as! String
                let relieves = relieveRequests.components(separatedBy: ",")
                
                let spineMovementRequests = doc.data()[FirebaseConstant.YogaPoseConstants.spineMovement] as! String
                guard let spineMovement = SpineMovement(rawValue: spineMovementRequests) else{
                    return
                }
                
                let requestYogaPose = RequestYogaPose(name: poseName, altName: altName, difficulty: difficulty, position: position, recommendedTrimester: trimester, spineMovement: spineMovement, bodyPartTrained: bodyPartsEnum, exception: exceptions, relieve: relieves)
                
                self.poses.append(requestYogaPose)
            }
        }
        self.objectWillChange.send()
    }
}
