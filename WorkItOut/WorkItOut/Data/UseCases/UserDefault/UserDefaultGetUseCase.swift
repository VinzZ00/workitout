//
//  userDefaultGetUsecase.swift
//  Mamaste
//
//  Created by Elvin Sestomi on 19/11/23.
//

import Foundation

protocol UserDefaultGetProtocol {
    
    
    func getpregnantDate() -> Date?
}

class UserDefaultGetUseCase : UserDefaultGetProtocol {
    let userDef = UserDefaults.standard
    
    
    func getpregnantDate() -> Date? {
        if let pregDate = userDef.object(forKey: "pregDate") {
            return pregDate as? Date ?? nil
        } else {
            return nil
        }
    }
    
}
