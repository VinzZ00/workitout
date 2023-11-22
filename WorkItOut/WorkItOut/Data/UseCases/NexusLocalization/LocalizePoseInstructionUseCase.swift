//
//  LocalizePoseInstructionUseCase.swift
//  Mamaste
//
//  Created by Elvin Sestomi on 22/11/23.
//

import Foundation

class LocalizePoseInstructionUseCase {
    
    let repository = Repository()
    
    func call(poses : [Pose]) async throws -> [Pose] {
        switch await repository.nexusAPI.getLangResource(lang: "id", poseNames: poses.map{$0.name}) {
        case .success(let data):
            var localizedPoses : [Pose] = []
            
            poses.forEach { p in
                var instructionString = data[p.name];
                
                var locPose = p
                
                locPose.instructions = instructionString!.split(separator: "# ") as? [String] ?? []
                
                localizedPoses.append(locPose);
            }
            
            return localizedPoses
            
            
        case .failure(let err):
            throw NSError(domain: "Error in hitting the API with err : \(err.localizedDescription)", code: -98)
        }
    }
}
