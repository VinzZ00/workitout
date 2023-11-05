//
//  HandmadeYogaPlans.swift
//  WorkItOut
//
//  Created by Jeremy Raymond on 05/11/23.
//

import Foundation

@MainActor
struct HandmadeYogaPlans {
    static var dm: DataManager = DataManager()
    static var yogaPlans: [YogaPlan] = loadYogaPlan()
    
    static func loadYogaPlan() -> [YogaPlan] {
        var yogaPlan: [YogaPlan] = []
        
        for relieve in Relieve.allCases { relieve
            var yogaPlan = dm.createYogaPlan(trimester: Trimester.allCases.randomElement()!, days: [.friday], duration: .tenMinutes)
        }
        
        return yogaPlan
    }
}
