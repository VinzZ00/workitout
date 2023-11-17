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
    
    func call(history : History, context : NSManagedObjectContext, yoga : Yoga, yogaPlan : YogaPlan) async throws{
        switch try await repo.coreData.fetchFromCoreData(context: context, entity: ProfileNSObject.self) {
        case .success(let data):
            guard let profile = (data as! [ProfileNSObject]).last else {
                fatalError("Error getting workout : the profile is empty");
            }
            
            var nsHistory = history.intoNSObject(context: context, parentProfileNS: profile) as! HistoryNSObject
            
            let nsYoga = ((profile.plan!.allObjects as! [YogaPlanNSObject]).first{ $0.uuid == yogaPlan.id}?
                .yogas!.allObjects as! [YogaNSObject]).first { $0.uuid
                    ==  yoga.id}!
            // ganti yogaState
            nsYoga.setValue("completed", forKey: "yogaState")
            
            // tambah relationship history dari nsyoga
            nsYoga.ofHistory = nsHistory
            
            try await repo.coreData.updateToCoreData(entity: nsYoga, context: context)
            
            switch try await repo.coreData.fetchFromCoreData(context: context, entity: YogaNSObject.self) {
            case .success(let data) :
                (data as! [YogaNSObject]).forEach { yg in
                    if yg.ofYogaPlan == nil {
                        context.delete(yg)
                    }
                }
                try context.save();
            case .failure(let err) :
                print("Error delete the duplicate row")
            }
        case .failure(let err):
            fatalError("Error getting workout : \(err.localizedDescription)")
        }
    }
}
