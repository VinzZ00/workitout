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
    
    func call(history : History, context : NSManagedObjectContext, yoga : Yoga) async throws{
        switch try await repo.coreData.fetchFromCoreData(context: context, entity: ProfileNSObject.self) {
        case .success(let data):
            guard let profile = (data as! [ProfileNSObject]).last else {
                fatalError("Error getting workout : the profile is empty");
            }
            
            var nsHistory = history.intoNSObject(context: context, parentProfileNS: profile) as! HistoryNSObject
            
            let yoga = yoga.intoNSObject(context: context, parentHistoryNS: nsHistory) as? YogaNSObject
            
            
            // Validasi supaya tidak yogaplan tidak kosong.
            if let _ = yoga?.ofYogaPlan {
                nsHistory.yogaDone = yoga!
            }
            
            nsHistory.yogaDone = yoga
            
            
            try await repo.coreData.saveToCoreData(entity: nsHistory, context: context)
            
            
        case .failure(let err):
            fatalError("Error getting workout : \(err.localizedDescription)")
        }
    }
}
