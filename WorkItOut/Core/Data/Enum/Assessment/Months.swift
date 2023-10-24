//
//  Months.swift
//  WorkItOut
//
//  Created by Kevin Dallian on 24/10/23.
//

import Foundation

enum Months : String, CaseIterable {
    case oneMonth = "One Month"
    case twoMonth = "Two Months"
    case threeMonth = "Three Months"
    case sixMonth = "Six Months"
    
    var description : String {
        var desc = ""
        switch self {
        case .oneMonth:
            desc = "Kickstart a healthier lifestyle or prepare for a specific event."
        case .twoMonth:
            desc = "I Want to commit to a short-term fitness or exercise program"
        case .threeMonth:
            desc = "Build consistency and gradually make exercise a habit"
        case .sixMonth:
            desc = "Achieving my fitness goals and willing to dedicate to see substantial results"
        }
        return desc
    }
}
