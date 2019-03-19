//
//  UserData.swift
//  Happie
//
//  Created by G.F Offringa on 08-06-17.
//  Copyright © 2017 femkeo. All rights reserved.
//

import Foundation

class UserData{
    
    func creatingUserData() -> [String: Any]{
        if userDataExists(){
            UserDefaults.standard.setValue(createDefaultUserData(), forKey: "SettingsDict")
        }
        return UserDefaults.standard.dictionary(forKey: "SettingsDict") ?? [String: Any]()
    }
    
    func userDataExists() -> Bool{
        return UserDefaults.standard.dictionary(forKey: "SettingsDict") != nil
    }
    
    func createDefaultUserData() -> [String: Any]{
        let defaultUser = [
            "hair" : "Hair1",
            "skin" : "Skin1",
            "clothes" : "Clothes1",
            "dream" : "Vul hier je droom in",
            "userScore" : 0.0
            ] as [String : Any]
        return defaultUser
    }

}
