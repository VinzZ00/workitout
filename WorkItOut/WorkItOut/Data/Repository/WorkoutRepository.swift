//
//  WorkoutRepository.swift
//  WorkItOut
//
//  Created by Elvin Sestomi on 23/10/23.
//

import Foundation

struct Repository {
    let coreData : CoreDataDataSource = CoreDataDataSource()
    var nexusAPI : NexusLocalizationAPIDataSource {
        
        var lang =  Locale.current.language.languageCode!.identifier
        
        do {
            return try NexusLocalizationAPIDataSource(lang: lang)
        } catch let err {
            fatalError("Error initiate nexus localization data source with error : \(err.localizedDescription)")
        }
    }
}




