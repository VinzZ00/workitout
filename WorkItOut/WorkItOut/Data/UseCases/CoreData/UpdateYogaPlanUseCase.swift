//
//  UpdateYogaPlanUseCase.swift
//  Mamaste
//
//  Created by Elvin Sestomi on 21/11/23.
//

import Foundation
import CoreData

struct UpdateYogaPlanUseCase {
    var repository = Repository()
        
    func call(profile : Profile, context : NSManagedObjectContext) async throws {
        switch try await repository.coreData.fetchFromCoreData(context: context, entity: ProfileNSObject.self) {
        case .success(let data):
            let profilens = data.last! as! ProfileNSObject
            
            let newHist = profile.histories.filter({ h in
                !(profilens.histories!.allObjects as! [HistoryNSObject]).map{$0.uuid}.contains(h.id)
            }).map{$0.intoNSObject(context: context, parentProfileNS: profilens)}
            
            (profilens.plan?.allObjects as! [YogaPlanNSObject]).forEach { ygp in
                profilens.removeFromPlan(ygp)
                
                context.delete(ygp)
                try? context.save()
            }
            
            profile.plan.map{$0.intoNSObject(context: context, parentProfileNSObject: profilens)}.forEach{ obj in
                profilens.addToPlan( obj as! YogaPlanNSObject)
            }
            
            try await repository.coreData.updateToCoreData(entity: profilens, context: context)
            
        case .failure(let err):
            fatalError("Error Update yogaPlan, tidak berhasil melakukan fetch didalam updateUsecase with err : \(err.localizedDescription)")
        }
    }
    
}
