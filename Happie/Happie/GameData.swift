//
//  GameData.swift
//  Happie
//
//  Created by G.F Offringa on 05-06-17.
//  Copyright © 2017 femkeo. All rights reserved.
//

import Foundation

class GameData{
    //create a variable that can be edited and resaved in the user default
    var Games = [String : [String : [String : [String: Any]]]] ()
    
    func creatingGames(){
        //creatingGames
        //if there is no data already saved, take care of that now
        if UserDefaults.standard.dictionary(forKey: "Games") == nil {
            Games = [
                "Categories" : [
                    "Droom het" : [
                        "Raad mijn droom" : [
                            "counter": 0,
                            "easy" : true,
                            "medium" : false,
                            "hard" : false
                        ],
                        "Foto challenge" : [
                            "counter": 0,
                            "easy" : true,
                            "medium" : false,
                            "hard" : false
                        ],
                        "Raad de tekening" : [
                            "counter": 0,
                            "easy" : true,
                            "medium" : false,
                            "hard" : false
                        ]
                    ],
                    "Speel het" : [
                        "Dilemma's" : [
                            "counter": 0,
                            "easy" : true,
                            "medium" : false,
                            "hard" : false
                        ],
                        "Ik heb een droom en ik neem mee" : [
                            "counter": 0,
                            "easy" : true,
                            "medium" : false,
                            "hard" : false
                        ],
                        "Quick quiz" : [
                            "counter": 0,
                            "easy" : true,
                            "medium" : false,
                            "hard" : false
                        ]
                    ],
                    "Doe het" : [
                        "Welja, geen nee" : [
                            "counter": 0,
                            "easy" : true,
                            "medium" : false,
                            "hard" : false
                        ],
                        "Kwaliteiten quiz" : [
                            "counter": 0,
                            "easy" : true,
                            "medium" : false,
                            "hard" : false
                        ],
                        "Wat is mijn karakter" : [
                            "counter": 0,
                            "easy" : true,
                            "medium" : false,
                            "hard" : false
                        ]
                    ]
                ]
            ]
            //safe to userdefault
            UserDefaults.standard.setValue(Games, forKey: "Games")
        }else{
            //if there is data retrieve fill the variable with it
            Games = UserDefaults.standard.dictionary(forKey: "Games") as! [String : [String : [String : [String : Any]]]]
        }
        
    }
    //return the variable so others can add new data to it
    var result: [String : [String : [String : [String : Any]]]]{
        get{
            return Games
        }
    }

}
