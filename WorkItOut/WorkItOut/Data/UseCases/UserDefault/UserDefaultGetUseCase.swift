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
    var userDef = UserDefaults.standard
    var propListDecoder = PropertyListDecoder();
    
    func getpregnantDate() -> Date? {
        if let pregDate = userDef.data(forKey: "pregDate") {
            if let date = try? propListDecoder.decode(Date.self, from: pregDate) {
                return date
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
    
}
