//
//  GameSelectingViewController.swift
//  Happie
//
//  Created by G.F Offringa on 29-05-17.
//  Copyright © 2017 femkeo. All rights reserved.
//

import UIKit

class GameSelectingViewController: UIViewController {

    
    @IBOutlet var firstGameButtons: [UIButton]!
    @IBOutlet var secondGameButtons: [UIButton]!
    @IBOutlet var thirdGameButtons: [UIButton]!
    @IBOutlet var allButtons: [UIButton]!
<<<<<<< HEAD
    @IBOutlet var allImages: [UIImageView]!
    
    
=======
    @IBOutlet var allLabels: [UILabel]!
    @IBOutlet var allLevelViews: [UIView]!
    @IBOutlet var allImages: [UIImageView]!
    

//    var categoryOne = ["Game1.0", "Game1.1", "Game1.2", "Game2.0", "Game2.1", "Game2.2", "Game3.0", "Game3.1", "Game3.2"]
//    var categoryTwo = ["Game4.0", "Game4.1", "Game4.2", "Game5.0", "Game5.1", "Game5.2", "Game6.0", "Game6.1", "Game6.2"]
//    var categoryThree = ["Game7.0", "Game7.1", "Game7.2", "Game8.0", "Game8.1", "Game8.2", "Game9.0", "Game9.1", "Game9.2"]
>>>>>>> 966332d29712f3f52a53425fd868db6a38acfbcc

    //var number = 0

    
    var labelsOne = ["Raad de Tekening", "Wat is mijn droom?", "Foto-challenge"]
    
    var imagesOne = ["drawingGuessEasy","drawingGuessMedium","drawingGuessHard","dreamGuessEasy","dreamGuessMedium","dreamGuessHard","fotoChallengeEasy","fotoChallengeMedium","fotoChallengeHard"]

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
       
    }

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //this uses the info of the button on the previous page to correct
        
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
<<<<<<< HEAD
            case "Droom het" : categoryArray = Array(categoryUserData["Droom het"]!.keys)
            case "Speel het" : categoryArray = Array(categoryUserData["Speel het"]!.keys)
            case "Doe het" : categoryArray = Array(categoryUserData["Doe het"]!.keys)
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
=======
            case "Droom het" : categorieArray = Array(categoryUserData["Droom het"]!.keys)
            fillingCurrentLabel()
            case "Speel het" : categorieArray = Array(categoryUserData["Speel het"]!.keys)
            fillingCurrentLabel()
            case "Doe het" : categorieArray = Array(categoryUserData["Doe het"]!.keys)
            fillingCurrentLabel()
            default: categorieArray = Array(categoryUserData["Droom het"]!.keys)
            
        for levelView in allLevelViews{
            levelView.layer.cornerRadius = 8.0
            levelView.backgroundColor = UIColor(red: 253/255, green: 252/255, blue: 248/255, alpha: 1)

        }
        
//        for label in allLabels{
//            label.layer.borderWidth = 2
//            label.layer.borderColor = UIColor.black.cgColor
//        }
        
//        for image in allImages{
//            image.contentMode = UIViewContentMode.scaleAspectFit;
//        }
        
        
>>>>>>> 966332d29712f3f52a53425fd868db6a38acfbcc
    }

    }

    
    
    func fillingCurrentLabel(){
        var categoryNumber = 0
            //this is the array of difficulties
            //for each label do something
            for i in 0..<allButtons.count{
                //check if the difficulty that is used is true or false.
                let checkingBool = userData["Categories"]![PreviousButtonTitle]![categoryArray[categoryNumber]]![difficultyArray[difficultyNumber]]! as! Bool
                
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
        allButtons[i].setTitle(difficultyArray[difficultyNumber], for: .normal)
        allButtons[i].setTitleColor(UIColor.clear, for: .normal)
        allButtons[i].isEnabled = true
        allImages[i].alpha = 1.0
    }
    
    //if the game is not playable
    func gameStateIsFalse(i: Int){
        allButtons[i].setTitle(difficultyArray[difficultyNumber], for: .normal)
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
                performSegue(withIdentifier: "GameToQuiz", sender: self)
            }
        default: performSegue(withIdentifier: "GameToOne", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GameToOne" {
            let viewController = segue.destination as! oneButtonViewController
            viewController.previousDifficulty = difficulty
            viewController.previousCategory = category
        }
        if segue.identifier == "GameToDraw" {
            let viewController = segue.destination as! drawingViewController
            viewController.previousDifficulty = difficulty
            viewController.previousCategory = category
        }
        if segue.identifier == "GameToMultiple" {
            let viewController = segue.destination as! MulipleAnswersViewController
            viewController.previousDifficulty = difficulty
            viewController.previousCategory = category
        }
        if segue.identifier == "GameToTableView" {
            let viewController = segue.destination as! TableViewController
            viewController.previousDifficulty = difficulty
            viewController.previousCategory = category
        }
        if segue.identifier == "GameToQuiz" {
            let viewController = segue.destination as! QuizViewController
            viewController.previousDifficulty = difficulty
            viewController.previousCategory = category
        }
        
    }

    
    @IBAction func UnwindtoGames(segue: UIStoryboardSegue) {
        
    }


}
