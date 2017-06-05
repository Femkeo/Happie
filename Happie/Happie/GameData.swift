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
                "DroomHet" : [
                    "RaadMijnDroom" : [
                        "counter": 0,
                        "easy" : true,
                        "medium" : false,
                        "hard" : false
                    ],
                    "FotoChallenge" : [
                        "counter": 0,
                        "easy" : true,
                        "medium" : false,
                        "hard" : false
                    ],
                    "RaadDeTekening" : [
                        "counter": 0,
                        "easy" : true,
                        "medium" : false,
                        "hard" : false
                    ]
                ],
                "SpeelHet" : [
                    "Dilemmas" : [
                        "counter": 0,
                        "easy" : true,
                        "medium" : false,
                        "hard" : false
                    ],
                    "IkHebEenDroomEnIkNeemMee" : [
                        "counter": 0,
                        "easy" : true,
                        "medium" : false,
                        "hard" : false
                    ],
                    "QuickQuiz" : [
                        "counter": 0,
                        "easy" : true,
                        "medium" : false,
                        "hard" : false
                    ]
                ],
                "DoeHet" : [
                    "WeljaGeenNee" : [
                        "counter": 0,
                        "easy" : true,
                        "medium" : false,
                        "hard" : false
                    ],
                    "KwaliteitenQuiz" : [
                        "counter": 0,
                        "easy" : true,
                        "medium" : false,
                        "hard" : false
                    ],
                    "WatIsMijnKarakter" : [
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
