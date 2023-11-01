//
//  ExecutionViewModel.swift
//  WorkItOut
//
//  Created by Angela Valentine Darmawan on 25/10/23.
//

import Foundation
import CoreData

class ExecutionViewModel: ObservableObject {
    var fetch: FetchYogaPlanUsecase = FetchYogaPlanUsecase()
    var yogaPlan: [YogaPlan] = []
    var yogas: [Yoga] = []
    @Published var index = 0
    var end = false
    
    func addPlan(context: NSManagedObjectContext) async {
        yogaPlan = await fetch.call(context: context)
    }
    
    func todayPlan() {
        for plan in yogaPlan{
            for yoga in plan.yogas {
                if (yoga.day.getWeekday() == Date()) {
                    yogas.append(yoga)
                }
            }
        }
    }
    
    func nextPose(){
        index += 1
        self.objectWillChange.send()
    }
}
