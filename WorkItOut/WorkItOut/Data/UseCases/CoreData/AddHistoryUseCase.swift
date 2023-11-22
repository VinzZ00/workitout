//
//  AddHistory.swift
//  Mamaste
//
//  Created by Elvin Sestomi on 17/11/23.
//

import Foundation
import CoreData

struct AddHistoryUseCase {
    var repo = Repository()
    
    func call(history : History, context : NSManagedObjectContext) async throws{
        switch try await repo.coreData.fetchFromCoreData(context: context, entity: ProfileNSObject.self) {
        case .success(let data):
            guard let profile = (data as! [ProfileNSObject]).last else {
                fatalError("Error getting workout : the profile is empty");
            }
            
            let nsHistory = history.intoNSObject(context: context, parentProfileNS: profile) as! HistoryNSObject
            
            nsHistory.yogaDone = (history.yogaDone.intoNSObject(context: context, parentHistoryNS: nsHistory) as! YogaHistoryNSObject)
            
            history.yogaDone.poses.forEach { hpose in
                nsHistory.yogaDone?.addToHistoryofPoses(hpose.intoNSObject(context: context, parentYogaHistoryNS: nsHistory.yogaDone!) as! PoseHistoryNSObject)
            }
            
            try await repo.coreData.saveToCoreData(entity: nsHistory, context: context)
            
            switch try await repo.coreData.fetchFromCoreData(context: context, entity: YogaNSObject.self) {
            case .success(let data) :
                var updatedYoga = (data as! [YogaNSObject]).first { yg in
                    nsHistory.yogaDone?.uuid == yg.uuid
                }
                
                updatedYoga?.setValue("completed", forKey: "yogaState")
                try await repo.coreData.updateToCoreData(entity: updatedYoga!, context: context)
            case .failure(let err) :
                print("Error fetching the yogaNSObject with : \(err.localizedDescription)")
            }
            
            
        case .failure(let err):
            fatalError("Error getting workout : \(err.localizedDescription)")
        }
    }
}
