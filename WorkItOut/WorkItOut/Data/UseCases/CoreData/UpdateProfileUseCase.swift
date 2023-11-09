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
//        do {
            
            switch try await repository.coreData.fetchFromCoreData(context: context, entity: ProfileNSObject.self) {
            case .success(let data) :
                let profilens = data.last! as! ProfileNSObject
                
                let newHist = profile.histories.filter({ h in
                    !(profilens.histories!.allObjects as! [HistoryNSObject]).map{$0.uuid}.contains(h.id)
                }).map{$0.intoNSObject(context: context, parentProfileNS: profilens)}
                                                                 
                
                let newYogaPlan = profile.plan.filter({ yp in
                    !(profilens.plan!.allObjects as! [YogaPlanNSObject]).map{$0.uuid}.contains(yp.id)
                }).map{$0.intoNSObject(context: context, parentProfileNSObject: profilens)}
                
                // MARK: Adding History (Relation)
//                profilens.setValue(newHist, forKey: "histories")
                newHist.forEach { his in
                    var hist = his as! HistoryNSObject
                    
                    if ((profilens.histories!.contains(hist))) {
                        profilens.addToHistories(hist)
                    }
                }
                
                // MARK: Adding yogaPlan (Relation)
//                profilens.setValue(newYogaPlan, forKey: "plan")
                newYogaPlan.forEach{ ygp in
                    var yp = ygp as! YogaPlanNSObject
                    if !profilens.plan!.contains(yp) {
                        profilens.addToPlan(yp)
                    }
                }
                
                
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
//        } catch let err {
//            fatalError("Error update workout: \(err.localizedDescription)")
//        }
    }
}
