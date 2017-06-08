//
//  MulipleAnswersViewController.swift
//  Happie
//
//  Created by G.F Offringa on 06-06-17.
//  Copyright © 2017 femkeo. All rights reserved.
//

import UIKit

class MulipleAnswersViewController: UIViewController {

    
    @IBOutlet weak var preferenceLabel: UILabel!
    @IBOutlet weak var ofLabel: UILabel!
    @IBOutlet var buttons: [UIButton]!
    
    
    var gameFromPrevious = ""
    var Reader = PropertyReader()

    var difficultyFromPrevious = ""
    var nextDifficulty = ""
    var gameCategory = ""
    var difficultyArray = ["easy", "medium", "hard"]
    
    var userData = UserDefaults.standard.dictionary(forKey: "Games") as! [String : [String : [String : [String : Any]]]]
    var number = 0
    
    override func viewWillAppear(_ animated: Bool) {
        checkingDifficulties()
        checkingGameCategory(game: gameFromPrevious)

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        for button in buttons{
            button.layer.cornerRadius = 7.0
            button.layer.borderWidth = 2.0
            button.layer.borderColor = UIColor.black.cgColor
            button.titleLabel?.textAlignment = NSTextAlignment.center
            button.contentEdgeInsets = UIEdgeInsetsMake(5,5,5,5)
        }
        
        
        Reader.readPropertyLists(startedFromSection: gameFromPrevious)
        
        for i in 0..<buttons.count {
            buttons[i].setTitle(Reader.pListDictResult["NewItem\(number)"]?[i], for: .normal)
        }

    }
    
    @IBAction func buttonsAction(_ sender: UIButton) {
        if sender.currentTitle == "Klaar!"{
            savingAndGoingBack()
        }else{
            if number != 9{
                number += 1
                for i in 0..<buttons.count {
                    buttons[i].setTitle(Reader.pListDictResult["NewItem\(number)"]?[i], for: .normal)
                }
            }else{
                for _ in 0..<buttons.count {
                    buttons[0].backgroundColor = UIColor.clear
                    buttons[0].setTitleColor(UIColor.black, for: .normal)
                    buttons[0].layer.borderColor = UIColor.clear.cgColor
                    buttons[0].isEnabled = false
                    buttons[0].setTitle("Het maken van keuzes is moeilijk. Gelukkig kom je niet iedere dag de dilemma’s tegen die je zonet hebt moeten doorlopen!", for: .normal)
                    buttons[1].setTitle("Klaar!", for: .normal)
                    ofLabel.text = ""
                    preferenceLabel.text = " "
                    
                }
            }
        }
        
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
        self.performSegue(withIdentifier: "BackToGameFromMulitple", sender: self)
        
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
