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
        let userDefault = UserDefaults.standard;
        
        
        if currentWeek > 0 {
            let cal = Calendar.current
            let pregnantDate = cal.date(byAdding: .weekOfYear, value: -currentWeek, to: Date.now);
            userDefault.set(pregnantDate, forKey: "pregDate")
            
            return true
        } else {
            return false
        }
        
    }
}
