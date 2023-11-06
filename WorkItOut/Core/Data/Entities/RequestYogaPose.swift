//
//  RequestYogaPose.swift
//  WorkItOut
//
//  Created by Kevin Dallian on 31/10/23.
//

import Foundation

struct RequestYogaPose {
    var yogaPose : String
    var altName : String
    var category: Category
    var difficulty : Difficulty
    var exceptions : [Exception]
    var recommendedTrimester : Trimester
    var relieves : [Relieve]
    var status : Status
}
