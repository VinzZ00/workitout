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
    @Published var trimester: Int = 0
    @Published var profile: [Profile] = []
    @Published var yogaPlan: [YogaPlan] = []
    @Published var yogas: [Yoga] = []
    @Published var pose: [Pose] = []
    @Published var index = 0
    @Published var end = false
    @Published var start = true
    
//    init(moc : NSManagedObjectContext) {
//        Task {
//            await addProfile(context: moc)
//            call()
//        }
//    }
    
//    func addProfile(context: NSManagedObjectContext) async {
//        profile = await fetch.call(context: context)
//    }
    
    
    init() {
        addprofile()
        getTrimester()
        getYogaPlan()
        getYoga()
        getPose()
    }
    
    func addprofile(){
        profile.append(MockData.mockProfile)
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
        let date = Calendar.current.component(.weekday, from: Date()) - 1
        
        for plan in yogaPlan{
            for yoga in plan.yogas {
                print("\(yoga.day.getInt()) date \(date)")
                if (yoga.day.getInt() == date) {
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
    
    func call(){
        getTrimester()
        getYogaPlan()
        getYoga()
        getPose()
    }
    
    func nextPose(){
        if index < pose.count-1 {
            index += 1
            self.objectWillChange.send()
        }else{
            end = true
        }
    }
    
    func previousPose(){
        if index > 0 {
            index -= 1
            self.objectWillChange.send()
        }else{
            end = true
        }
    }
}
