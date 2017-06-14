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
    var gameFromPrevious = ""
    var difficultyFromPrevious = ""
    var nextDifficulty = ""
    var difficultyArray = ["easy", "medium", "hard"]
    var gameCategory = ""
    
    var userData = UserDefaults.standard.dictionary(forKey: "Games") as! [String : [String : [String : [String : Any]]]]
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        checkingDifficulties()
        checkingGameCategory(game: gameFromPrevious)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showDreamLabel.text = "Geef de telefoon aan de persoon die zijn of haar droom moet raden en laat die persoon het scherm indrukken wanneer deze hem tegen het hoofd heeft"
        
        showDreamLabel.adjustsFontSizeToFitWidth = true
        showDreamLabel.minimumScaleFactor = 0.2
        showDreamLabel.numberOfLines = 4
    }
    
    @IBAction func passDeficeButtonAction(_ sender: Any) {
        passDeficeButton.isEnabled = false
        showDreamLabel.text = currentDream
    }
    
    @IBAction func doneButtonAction(_ sender: Any) {
        savingAndGoingBack()
    }
    
    func checkingGameCategory(game: String){
        let droomGames = Array(userData["Categories"]!["Droom het"]!.keys)
        let speelGames = Array(userData["Categories"]!["Speel het"]!.keys)
        let doeGames = Array(userData["Categories"]!["Doe het"]!.keys)
        
        if droomGames.contains(game){
            gameCategory = "Droom het"
        }else if speelGames.contains(game){
            gameCategory = "Speel het"
        }else if doeGames.contains(game){
            gameCategory = "Doe het"
        }
    }
    
    func checkingDifficulties(){
        let indexOfDifficulty = difficultyArray.index(of: difficultyFromPrevious)
        if indexOfDifficulty == 2{
            nextDifficulty = difficultyFromPrevious
        }else{
            nextDifficulty = difficultyArray[indexOfDifficulty! + 1]
        }
    }
    
    func savingAndGoingBack(){
        self.performSegue(withIdentifier: "BackToGameFromDream", sender: self)
        
        var newCounterValue = 0
        let counter = userData["Categories"]![gameCategory]![gameFromPrevious]!["counter"]! as! Int
        newCounterValue = counter + 1
        
        let dataToUpdate = GameData()
        dataToUpdate.creatingGames()
        var newData = dataToUpdate.result
        
        newData["Categories"]![gameCategory]![gameFromPrevious]![nextDifficulty]! = true
        
        newData["Categories"]![gameCategory]![gameFromPrevious]!["counter"] = newCounterValue
        
        UserDefaults.standard.set(newData, forKey: "Games")
    }


}
