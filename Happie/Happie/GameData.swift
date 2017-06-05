//
//  GameData.swift
//  Happie
//
//  Created by G.F Offringa on 05-06-17.
//  Copyright © 2017 femkeo. All rights reserved.
//

import Foundation

class GameData{
 
    private var Games = [String : [String : [String : [String: Any]]]] ()
    
    func creatingGames(){
        //creatingGames
        
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
        UserDefaults.standard.setValue(Games, forKey: "Games")
        
    }

}
