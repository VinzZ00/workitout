//
//  fetchWorkoout.swift
//  WorkItOut
//
//  Created by Elvin Sestomi on 23/10/23.
//

import Foundation
import CoreData

struct FetchProfileUseCase{
    
    let repository = Repository()
    
    func call(context : NSManagedObjectContext) async -> [Profile]{
        
        var workoutPlans : [Profile] = []
        
        do {
            switch try await repository.coreData.fetchFromCoreData(context: context, entity: ProfileNSObject.self) {
            case .success(let data) :
                for x in data as? [ProfileNSObject] ?? [] {
                    
//                    var profile = Profile(
//                        name: x.name ?? "No Name",
//                        currentPregnancyWeek: Int(x.currentPregnancyWeek),
//                        currentRelieveNeeded: x.currentRelieveNeeded?.split(separator: ", ").map{Relieve(rawValue: String($0))!} ?? [],
//                        fitnessLevel: Difficulty(rawValue: x.fitnessLevel!)!,
//                        daysAvailable: x.daysAvailable!.split(separator: ", ").map{Day(rawValue: String($0))!},
//                        timeOfDay: TimeOfDay(rawValue: x.timeOfDay!)!,
//                        preferredDuration: Duration(rawValue: x.preferredDuration!)!,
//                        plan: x.plan?.allObjects as? [YogaPlanNSObject] ?? [],
//                        histories: x.histories?.allObjects as? [HistoryNSObject] ?? []
//                    )
                    
//                    profile.yogas = x.yogas?.allObjects as? [YogaNSObject] ?? []
//                    
//                    profile.id = x.uuid!
//                    profile.name = x.name!
                    
                    
                    workoutPlans.append(x.intoObject());
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
