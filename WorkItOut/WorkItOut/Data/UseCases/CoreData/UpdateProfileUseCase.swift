//
//  UpdateWorkoutUseCase.swift
//  WorkItOut
//
//  Created by Elvin Sestomi on 23/10/23.
//

import Foundation
import CoreData

struct UpdateProfileUseCase {
    var repository = Repository()
    
    func call(profile : Profile, context : NSManagedObjectContext) async throws {
        switch try await repository.coreData.fetchFromCoreData(context: context, entity: ProfileNSObject.self) {
        case .success(let data) :
            let profilens = data.last! as! ProfileNSObject
            
            let newHist = profile.histories.filter({ h in
                !(profilens.histories!.allObjects as! [HistoryNSObject]).map{$0.uuid}.contains(h.id)
            }).map{$0.intoNSObject(context: context, parentProfileNS: profilens)}
            
            
            // MARK: Adding others self Field (Non Relation)
            profilens.setValue(profile.name, forKey: "name")
            profilens.setValue(profile.currentPregnancyWeek, forKey: "currentPregnancyWeek")
            profilens.setValue(profile.currentRelieveNeeded.map{$0.rawValue}.joined(separator: ", "), forKey: "currentRelieveNeeded")
            profilens.setValue(profile.daysAvailable.map{$0.rawValue}.joined(separator: ", "), forKey: "daysAvailable")
            profilens.setValue(profile.fitnessLevel.rawValue, forKey: "fitnessLevel")
            profilens.setValue(profile.preferredDuration.rawValue, forKey: "preferredDuration")
            profilens.setValue(profile.exceptions.map{$0.rawValue}.joined(separator: ", "), forKey: "exceptions")
            profilens.setValue(profile.timeOfDay.rawValue, forKey: "timeOfDay")
            
            try await repository.coreData.updateToCoreData(entity: profilens, context: context)
            
        case .failure(let err) :
            fatalError("Error Update, tidak berhasil melakukan fetch didalam updateUsecase with err : \(err.localizedDescription)")
        }
    }
    
    
}
