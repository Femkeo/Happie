//
//  GameSelectingViewController.swift
//  Happie
//
//  Created by G.F Offringa on 29-05-17.
//  Copyright © 2017 femkeo. All rights reserved.
//

import UIKit

class GameSelectingViewController: UIViewController {

    

    @IBOutlet var allButtons: [UIButton]!
    @IBOutlet var allImages: [UIImageView]!
    @IBOutlet var allGameLabels: [UILabel]!
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var categoryInfoLabel: UILabel!
    
    var PreviousButtonTitle = ""
    var userData = UserDefaults.standard.dictionary(forKey: "Games") as! [String : [String : [String : [String : Any]]]]
    var categoryArray = [String]()
    var gameAmount: Int?
    
    var difficultyNumber = 0
    var difficultyArray = ["easy", "medium", "hard"]
    var difficulty = ""
    
    var category = ""
    var buttonInfo = ""

    
    override func viewWillAppear(_ animated: Bool) {
        userData = UserDefaults.standard.dictionary(forKey: "Games") as! [String : [String : [String : [String : Any]]]]
        gettingCorrectInfo(category: PreviousButtonTitle)
        print(allImages.count)
       
    }

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //this uses the info of the button on the previous page to correct
        
        categoryInfoLabel.adjustsFontSizeToFitWidth = true
        categoryInfoLabel.minimumScaleFactor = 0.2
        categoryInfoLabel.numberOfLines = 50
        
        
    }
    
    
    
    @IBAction func firstGameButtonAction(_ sender: UIButton) {
        category = categoryArray[0]
        buttonInfo = sender.currentTitle!
        settingDifficulty(sender: buttonInfo)
        
    }
    
    @IBAction func secondGameAction(_ sender: UIButton) {
        category = categoryArray[1]
        buttonInfo = sender.currentTitle!
        settingDifficulty(sender: buttonInfo)
        
    }
    
    @IBAction func thirdGameAction(_ sender: UIButton) {
        category = categoryArray[2]
        buttonInfo = sender.currentTitle!
        settingDifficulty(sender: buttonInfo)
    }
    
    
    func settingDifficulty(sender: String){
        switch sender{
        case "easy" : difficulty = "easy"
        case "medium" : difficulty = "medium"
        case "hard" : difficulty = "hard"
        default : difficulty = "easy"
        }
        gettingCorrectSegue(category: category)
    }
    
    
    func gettingCorrectInfo(category: String){
        let categoryUserData = userData["Categories"] ?? Dictionary()
        var number = 0
        var catNumber = 0
        //this collects the names of the games that match each category
        
        switch category{
            case "Droom het" :
                categoryArray = Array(categoryUserData["Droom het"]!.keys)
                categoryImage.image = UIImage(named: "Droom het")
                categoryInfoLabel.text = "Speel en leer alle ins en outs van je droom kennen!"
            case "Speel het" :
                categoryArray = Array(categoryUserData["Speel het"]!.keys)
                categoryImage.image = UIImage(named: "Speel het")
                categoryInfoLabel.text = "Kies een spel om beter te worden in het maken van keuzes!"
            case "Doe het" :
                categoryArray = Array(categoryUserData["Doe het"]!.keys)
                categoryImage.image = UIImage(named: "Doe het")
                categoryInfoLabel.text = "Na het spelen van deze spellen barst je van het zelfvertrouwen!"
//                allGameLabels[0].text = "Welja, geen nee"
//                allGameLabels[1].text =
//                allGameLabels[2].text =
            default: categoryArray = Array(categoryUserData["Droom het"]!.keys)
        }
        
        fillingCurrentLabel()

        for image in 0..<allImages.count{
            allImages[image].image = UIImage(named: "\(categoryArray[catNumber])\(difficultyArray[number])")
            if number == 2{
                number = 0
                catNumber += 1
            }else{
                number += 1
            }
        }
    }

    
    
    func fillingCurrentLabel(){
        var categoryNumber = 0
            //this is the array of difficulties
            //for each label do something
            for i in 0..<allButtons.count{
                allButtons[i].setTitle(difficultyArray[difficultyNumber], for: .normal)
                print(difficultyArray[difficultyNumber])
                //check if the difficulty that is used is true or false.
                let checkingBool = userData["Categories"]![PreviousButtonTitle]![categoryArray[categoryNumber]]![difficultyArray[difficultyNumber]]! as! Bool
                print("\(categoryArray[categoryNumber]).\(difficultyArray[difficultyNumber]) = \(checkingBool)")
                allGameLabels[categoryNumber].text = categoryArray[categoryNumber]
                //if its true set it to active
                if checkingBool == true{
                    //First i is a placeholder for the function. Second i is in "for i in 0..<allbuttons.count"
                    gameStateIsTrue(i: i)
                    
                    //if its false set it to inactive
                }else{
                    //First i is a placeholder for the function. Second i is in "for i in 0..<allbuttons.count"
                    gameStateIsFalse(i: i)
                }
                
                //start over if 2 was reached (for the arrays)
                if difficultyNumber == 2{
                    difficultyNumber = 0
                    categoryNumber += 1
                }else{
                    difficultyNumber += 1
                }
            }
        }

    
    // if the game is playable
    func gameStateIsTrue(i: Int){
        
        allButtons[i].setTitleColor(UIColor.clear, for: .normal)
        allButtons[i].isEnabled = true
        allImages[i].alpha = 1.0
    }
    
    //if the game is not playable
    func gameStateIsFalse(i: Int){
        
        allButtons[i].setTitleColor(UIColor.clear, for: .normal)
        allButtons[i].isEnabled = false
        allImages[i].alpha = 0.1
    }
    
    
    //using the info from the buttonfunction to activate the right segue
    func gettingCorrectSegue(category: String){
        let checkingCounter = userData["Categories"]![PreviousButtonTitle]![category]!["counter"]! as! Int
        
        switch category{
        case "Raad mijn droom" :
            if checkingCounter == 0{
                print("checking is 0")
                performSegue(withIdentifier: "GameToOne", sender: self)
            }else{
                print("checking is not 0")
                performSegue(withIdentifier: "GameToTableView", sender: self)
            }
        case "Foto challenge" :
                performSegue(withIdentifier: "GameToOne", sender: self)
        case "Raad de tekening" :
            if checkingCounter == 0{
                print("checking is 0")
                performSegue(withIdentifier: "GameToOne", sender: self)
            }else{
                print("checking is not 0")
                performSegue(withIdentifier: "GameToDraw", sender: self)
            }
        case "Dilemma's" :
            if checkingCounter == 0{
                print("checking is 0")
                performSegue(withIdentifier: "GameToOne", sender: self)
            }else{
                print("checking is not 0")
                performSegue(withIdentifier: "GameToMultiple", sender: self)
            }
        case "Ik heb een droom en ik neem mee":
            performSegue(withIdentifier: "GameToOne", sender: self)
        case "Quick quiz" :
            if checkingCounter == 0{
                print("checking is 0")
                performSegue(withIdentifier: "GameToOne", sender: self)
            }else{
                print("checking is not 0")
                performSegue(withIdentifier: "GameToQuiz", sender: self)
            }
        case "Welja, geen nee":
            performSegue(withIdentifier: "GameToOne", sender: self)
        case "Kwaliteiten quiz":
            if checkingCounter == 0{
                print("checking is 0")
                performSegue(withIdentifier: "GameToOne", sender: self)
            }else{
                print("checking is not 0")
                performSegue(withIdentifier: "GameToQuiz", sender: self)
            }
        case "Wat is mijn karakter":
            if checkingCounter == 0{
                print("checking is 0")
                performSegue(withIdentifier: "GameToOne", sender: self)
            }else{
                print("checking is not 0")
                performSegue(withIdentifier: "GameToTableView", sender: self)
            }
        default: performSegue(withIdentifier: "GameToOne", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GameToOne" {
            let viewController = segue.destination as! oneButtonViewController
            viewController.difficultyFromPrevious = difficulty
            viewController.gameFromPrevious = category
        }
        if segue.identifier == "GameToDraw" {
            let viewController = segue.destination as! drawingViewController
            viewController.difficultyFromPrevious = difficulty
            viewController.gameFromPrevious = category
        }
        if segue.identifier == "GameToMultiple" {
            let viewController = segue.destination as! MulipleAnswersViewController
            viewController.difficultyFromPrevious = difficulty
            viewController.gameFromPrevious = category
        }
        if segue.identifier == "GameToTableView" {
            let viewController = segue.destination as! TableViewController
            viewController.difficultyFromPrevious = difficulty
            viewController.gameFromPrevious = category
        }
        if segue.identifier == "GameToQuiz" {
            let viewController = segue.destination as! QuizViewController
            viewController.difficultyFromPrevious = difficulty
            viewController.gameFromPrevious = category
        }
        
    }

    
    @IBAction func UnwindtoGames(segue: UIStoryboardSegue) {
        
    }


}
