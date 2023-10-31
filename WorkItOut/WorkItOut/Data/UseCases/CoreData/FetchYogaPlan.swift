//
//  fetchWorkoout.swift
//  WorkItOut
//
//  Created by Elvin Sestomi on 23/10/23.
//

import Foundation
import CoreData

struct FetchYogaPlanUsecase{
    
    let repository = Repository()
    
    func call(context : NSManagedObjectContext) async -> [YogaPlan]{
        
        var workoutPlans : [YogaPlan] = []
        
        do {
            switch try await repository.coreData.fetchFromCoreData(context: context, entity: YogaPlanNSObject.self) {
            case .success(let data) :
                for x in data as? [YogaPlanNSObject] ?? [] {
                    
                    var yogaPlan = YogaPlan()
                    
                    yogaPlan.yogas = x.yogas?.allObjects as? [YogaNSObject] ?? []
                    
                    yogaPlan.id = x.uuid!
                    yogaPlan.name = x.name!
                    yogaPlan.trimester = Trimester(rawValue: x.trimester!) ?? .all
                    
                    workoutPlans.append(yogaPlan);
                }
            case .failure(let err) :
                fatalError("Error getting workout : \(err.localizedDescription)")
            }
        } catch {
            fatalError("Error getting the workout")
        }
        return workoutPlans
    }
}
