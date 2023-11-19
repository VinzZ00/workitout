//
//  YogaDetailViewModel.swift
//  Mamaste
//
//  Created by Jeremy Raymond on 13/11/23.
//

import Foundation

class YogaDetailViewModel: ObservableObject {
    @Published var relievesPoses: [Pose] = []
    
    let oldYoga: Yoga
    @Published var newYoga: Yoga = Yoga()
    
    @Published var selectedRelieves: [Relieve] = []
    @Published var selections : [Relieve] = [.back, .hip, .neck, .leg, .pelvic]
    
    init(oldYoga: Yoga = Yoga()) {
        self.oldYoga = oldYoga
    }
    
    func addRelieves(yoga: Yoga) -> Yoga {
        var newYoga: Yoga = oldYoga
        
        for relieve in selectedRelieves {
            let filteredRelievePose = self.relievesPoses.filter({$0.relieve.contains(relieve)}).randomElement()
            if let relievePose = filteredRelievePose {
                newYoga.poses.append(relievePose)
            }
            self.objectWillChange.send()
        }
        
        return newYoga
    }
}
