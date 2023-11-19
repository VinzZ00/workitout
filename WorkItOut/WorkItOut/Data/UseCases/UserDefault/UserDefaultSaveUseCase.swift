//
//  userDefaultUsecase.swift
//  Mamaste
//
//  Created by Elvin Sestomi on 19/11/23.
//

import Foundation

protocol SetUserDefault {
    func saveToUserDefault(currentWeek : Int) -> Bool;
}

class UserDefaultSaveUseCase : SetUserDefault {
    func saveToUserDefault(currentWeek : Int) -> Bool{
        var userDefault = UserDefaults.standard;
        var propListEncoder = PropertyListEncoder();
        
        
        if currentWeek > 0 {
            var cal = Calendar.current
            var pregnantDate = cal.date(byAdding: .weekOfYear, value: -currentWeek, to: Date.now);
            
            if let encodedDate = try? propListEncoder.encode(pregnantDate) {
                userDefault.set(encodedDate, forKey: "pregDate")
                return true
            } else {
                return false;
            }
            
            
        } else {
            return false;
        }
        
    }
}
