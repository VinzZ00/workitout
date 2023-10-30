////
////  fetchWorkoout.swift
////  WorkItOut
////
////  Created by Elvin Sestomi on 23/10/23.
////
//
//import Foundation
//import CoreData
//
//struct FetchWorkoutPlanUseCase {
//    
//    let repository = Repository()
//    
//    func call(context : NSManagedObjectContext) async -> [WorkoutNSObject]{
//        
//        var workoutPlans : [WorkoutNSObject] = []
//        
//        do {
//            switch try await repository.coreData.fetchFromCoreData(context: context, entity: WorkoutNSObject.self) {
//            case .success(let data) :
//                for x in data as? [WorkoutNSObject] ?? [] {
//                    workoutPlans.append(x);
//                }
//            case .failure(let err) :
//                fatalError("Error getting workout : \(err.localizedDescription)")
//            }
//        } catch {
//            fatalError("Error getting the workout")
//        }
//        return workoutPlans
//    }
//}
