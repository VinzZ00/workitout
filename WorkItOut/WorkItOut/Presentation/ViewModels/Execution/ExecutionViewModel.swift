//
//  ExecutionViewModel.swift
//  WorkItOut
//
//  Created by Angela Valentine Darmawan on 25/10/23.
//

import Foundation
import CoreData

class ExecutionViewModel: ObservableObject {
    var fetch: FetchProfileUseCase = FetchProfileUseCase()
    var trimester: Int = 0
    var profile: [Profile] = []
    var yogaPlan: [YogaPlan] = []
    var yogas: [Yoga] = []
    @Published var pose: [Pose] = []
    @Published var index = 0
    var end = false
    
    func addProfile(context: NSManagedObjectContext) async {
        profile = await fetch.call(context: context)
    }
    
    func getTrimester(){
        for p in profile{
            if  1...13 ~= p.currentPregnancyWeek {
                trimester = 1
            }else if 14...27 ~= p.currentPregnancyWeek {
                trimester = 2
            }else {
                trimester = 3
            }
        }
    }
    
    func getYogaPlan() {
        for p in profile{
            for plan in p.plan{
                if plan.trimester.getInt() == trimester{
                    yogaPlan.append(plan)
                }
            }
        }
    }
    
    func getYoga() {
        for plan in yogaPlan{
            for yoga in plan.yogas {
                if (yoga.day.getWeekday() == Date()) {
                    yogas.append(yoga)
                }
            }
        }
    }
    
    func getPose() {
        for yoga in yogas{
            for p in yoga.poses{
                pose.append(p)
            }
        }
    }
    
    func poses() -> Pose{
        return pose[index]
    }
    
    func nextPose(){
        if index < pose.count-1 {
            index += 1
            self.objectWillChange.send()
        }else{
            end = true
        }
    }
}
