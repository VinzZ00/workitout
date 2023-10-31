//
//  HomeViewModel.swift
//  WorkItOut
//
//  Created by Jeremy Raymond on 31/10/23.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var days: [Day] = Day.allCases
    @Published var relieves: [Relieve] = [
        .backpain, .breathing, .hippain, .laborprep, .neckcramp, .pelvicflexibility
    ]
    @Published var selectedRelieve: Relieve = .backpain
    @Published var sheetToggle: Bool = false
}
