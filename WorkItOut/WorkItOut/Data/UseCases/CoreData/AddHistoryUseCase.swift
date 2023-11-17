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
            
            // tambah history
            nsYoga.ofHistory = nsHistory
            
            
            
//            profile.addToHistories(nsHistory)
            
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
                print("erorr delete the duplicate row")
            }
//
//            let yogaPlanNS = (profile.plan?.allObjects as! [YogaPlanNSObject]).first(where: { p in
//                p.uuid == yogaPlan.id
//            })
//            
//            let yogaNS = (yogaPlanNS?.yogas?.allObjects as! [YogaNSObject]).first { yg in
//                yg.uuid == yoga.id
//            }
//            
//            yogaNS?.ofHistory = nsHistory
//            
//            try await repo.coreData.updateToCoreData(entity: yogaNS!, context: context)
//            
//            
            
            
            
            
//            let yoga = yoga.intoNSObject(context: context, parentHistoryNS: nsHistory) as? YogaNSObject
            
            
//            switch try await repo.coreData.fetchFromCoreData(context: context, entity: YogaNSObject.self) {
//            case .success(let data):
//                let yogaNS = (data as? [YogaNSObject])?.first(where: { yg in
//                    yg.uuid == yoga.id
//                });
//                yogaNS?.yogaState = yoga.yogaState.rawValue
//                nsHistory.yogaDone = yogaNS
//                print("yogaNS?.ofYogaPlan : \(yogaNS?.ofYogaPlan)")
//                
//                switch try await repo.coreData.fetchFromCoreData(context: context, entity: ProfileNSObject.self) {
//                case .success(let fetchres) :
//                    var prof = fetchres as! [ProfileNSObject]
//                    
//                    var profile = prof.last;
//                case .failure(_):
//                    print("failed")
//                }
//                
//                
//                try await repo.coreData.saveToCoreData(entity: nsHistory, context: context)
//                
//            case .failure(let err):
//                fatalError("Error getting Yoga : \(err.localizedDescription)")
//            }
//            
//    
//            
//            
//            
//            
//            
        case .failure(let err):
            fatalError("Error getting workout : \(err.localizedDescription)")
        }
    }
}
