//
//  WhatDoIDreamViewController.swift
//  Happie
//
//  Created by G.F Offringa on 06-06-17.
//  Copyright © 2017 femkeo. All rights reserved.
//

import UIKit

class WhatDoIDreamViewController: UIViewController {

    @IBOutlet weak var passDeficeButton: UIButton!
    @IBOutlet weak var showDreamLabel: UILabel!
    
    
    var currentDream: String?
    var previousCategory = ""
    var previousDifficulty = ""
    var nextDifficulty = ""
    var difficultyArray = ["easy", "medium", "hard"]
    
    var userData = UserDefaults.standard.dictionary(forKey: "Games") as! [String : [String : [String : [String : Any]]]]
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        let indexOfDifficulty = difficultyArray.index(of: previousDifficulty)
        if indexOfDifficulty == 2{
        }else{
            nextDifficulty = difficultyArray[indexOfDifficulty! + 1]
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showDreamLabel.text = "Geef de telefoon aan de persoon die zijn of haar droom moet raden en laat die persoon het scherm indrukken wanneer deze hem tegen het hoofd heeft"
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func passDeficeButtonAction(_ sender: Any) {
        passDeficeButton.isEnabled = false
        showDreamLabel.text = currentDream
    }
    
    @IBAction func doneButtonAction(_ sender: Any) {
        self.performSegue(withIdentifier: "BackToGameFromDream", sender: self)
        var newCounterValue = 0
        let counter = userData["Categories"]!["Droom het"]![previousCategory]!["counter"]! as! Int
        newCounterValue = counter + 1
        
        let dataToUpdate = GameData()
        dataToUpdate.creatingGames()
        var newData = dataToUpdate.result
        
        newData["Categories"]!["Droom het"]![previousCategory]![nextDifficulty]! = true
        
        newData["Categories"]!["Droom het"]![previousCategory]!["counter"] = newCounterValue
        
        UserDefaults.standard.set(newData, forKey: "Games")
    }


}
