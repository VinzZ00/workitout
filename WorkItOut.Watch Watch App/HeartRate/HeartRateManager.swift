//
//  HeartRateManager.swift
//  WorkItOut
//
//  Created by Kevin Dallian on 24/10/23.
//

import Foundation
import HealthKit

class HeartRateManager : ObservableObject {
    var hkStore = HKHealthStore()
    @Published var heartRate : Int = 0
    
    func authorization() {
        let healthKitTypes : Set = [HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate)!]
        hkStore.requestAuthorization(toShare: healthKitTypes, read: healthKitTypes) { [self] success, error in
            if success {
                startHeartRateQuery(quantityTypeIdentifier: .heartRate)
            }
        }
    }
    
    func startHeartRateQuery(quantityTypeIdentifier: HKQuantityTypeIdentifier) {
        
        // We want data points from our current device
        let devicePredicate = HKQuery.predicateForObjects(from: [HKDevice.local()])
        print(devicePredicate)
        
        // A query that returns changes to the HealthKit store, including a snapshot of new changes and continuous monitoring as a long-running query.
        let updateHandler: (HKAnchoredObjectQuery, [HKSample]?, [HKDeletedObject]?, HKQueryAnchor?, Error?) -> Void = {
            query, samples, deletedObjects, queryAnchor, error in
            
            // A sample that represents a quantity, including the value and the units.
            guard let samples = samples as? [HKQuantitySample] else {
                return
            }
            
            self.process(samples, type: quantityTypeIdentifier)
            
        }
        
        // It provides us with both the ability to receive a snapshot of data, and then on subsequent calls, a snapshot of what has changed.
        let query = HKAnchoredObjectQuery(type: HKObjectType.quantityType(forIdentifier: quantityTypeIdentifier)!, predicate: nil, anchor: nil, limit: HKObjectQueryNoLimit, resultsHandler: updateHandler)
        
        query.updateHandler = updateHandler
        
        // query execution
        
        hkStore.execute(query)
    }
    
    private func process(_ samples: [HKQuantitySample], type: HKQuantityTypeIdentifier) {
        // variable initialization
        var lastHeartRate = 0.0
        
        // cycle and value assignment
        for sample in samples {
            let heartRateQuantity = HKUnit(from: "count/min")
            if type == .heartRate {
                lastHeartRate = sample.quantity.doubleValue(for: heartRateQuantity)
                print("start date : \(sample.startDate) last date : \(sample.endDate) with heart rate : \(lastHeartRate)")
            }
            DispatchQueue.main.async {
                self.heartRate = Int(lastHeartRate)
                self.objectWillChange.send()
            }
            
        }
    }
}
