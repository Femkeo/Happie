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
    
    
    var previousCategory = ""
    var Reader = PropertyReader()

    var previousDifficulty = ""
    var nextDifficulty = ""
    var difficultyArray = ["easy", "medium", "hard"]
    
    var userData = UserDefaults.standard.dictionary(forKey: "Games") as! [String : [String : [String : [String : Any]]]]
    var number = 0
    
    override func viewWillAppear(_ animated: Bool) {
        let indexOfDifficulty = difficultyArray.index(of: previousDifficulty)
        if indexOfDifficulty == 2{
        }else{
            nextDifficulty = difficultyArray[indexOfDifficulty! + 1]
        }
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
        
        
        Reader.readPropertyLists(startedFromSection: previousCategory)
        
        for i in 0..<buttons.count {
            buttons[i].setTitle(Reader.pListDictResult["NewItem\(number)"]?[i], for: .normal)
        }

    }
    
    @IBAction func buttonsAction(_ sender: UIButton) {
        if sender.currentTitle == "Klaar!"{
            self.performSegue(withIdentifier: "BackToGameFromMulitple", sender: self)
            var newCounterValue = 0
            let counter = userData["Categories"]!["Speel het"]![previousCategory]!["counter"]! as! Int
            newCounterValue = counter + 1
            
            let dataToUpdate = GameData()
            dataToUpdate.creatingGames()
            var newData = dataToUpdate.result
            
            newData["Categories"]!["Speel het"]![previousCategory]![nextDifficulty]! = true
            newData["Categories"]!["Speel het"]![previousCategory]!["counter"] = newCounterValue
            
            UserDefaults.standard.set(newData, forKey: "Games")
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
    

    
}
