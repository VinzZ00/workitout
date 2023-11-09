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
    
    func call(context : NSManagedObjectContext) async throws -> [Profile]{
        
        var profile : [Profile] = []
        
//        do {
            switch try await repository.coreData.fetchFromCoreData(context: context, entity: ProfileNSObject.self) {
            case .success(let data) :
                for x in data as? [ProfileNSObject] ?? [] {
                    var p = x.intoObject();
                    if p.plan.contains(where: { ygp in
                        !ygp.yogas.isEmpty
                    }) {
                        profile.append(p);
                    }
                    
                }
//                let s = data as! [ProfileNSObject]
//                profile.append(Profile(name: ""))
//                profile.insert(contentsOf: s.map{ $0.intoObject() }, at: 0)
//                print(data)
            case .failure(let err) :
                fatalError("Error getting workout : \(err.localizedDescription)")
            }
//        } catch {
//            fatalError("Error getting the workout")
//        }
        return profile
    }
}
