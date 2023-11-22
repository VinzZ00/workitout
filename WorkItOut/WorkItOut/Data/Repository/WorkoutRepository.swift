//
//  WorkoutRepository.swift
//  WorkItOut
//
//  Created by Elvin Sestomi on 23/10/23.
//

import Foundation

struct Repository {
    let coreData : CoreDataDataSource = CoreDataDataSource()
    let nexusAPI : NexusLocalizationAPIDataSource = NexusLocalizationAPIDataSource()
}




