//
//  UserData.swift
//  Happie
//
//  Created by G.F Offringa on 08-06-17.
//  Copyright © 2017 femkeo. All rights reserved.
//

import Foundation

class UserData{
    var Data = [String: Any]()
    
    func creatingUserData(){
        if UserDefaults.standard.dictionary(forKey: "SettingsDict") == nil{
            Data = [
                "hair" : "Hair1",
                "skin" : "Skin1",
                "clothes" : "Clothes1",
                "dream" : "Vul hier je droom in",
                "userScore" : 0.0
            ]
            UserDefaults.standard.setValue(Data, forKey: "SettingsDict")

        }else{
            Data = UserDefaults.standard.dictionary(forKey: "SettingsDict") ?? Dictionary()
        }
    }
    
    var result: [String: Any]{
        get{
            return Data
        }
    }
}
