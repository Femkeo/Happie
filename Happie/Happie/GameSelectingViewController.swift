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
    @IBOutlet var allImages: [UIImageView]!
    
    
    
    var categoryOne = ["Guesseasy", "Guessmedium", "Guesshard", "Fotoeasy", "Fotomedium", "Fotohard", "Draweasy", "Drawmedium", "Drawhard"]
    var categoryTwo = ["Dilemmaeasy", "Dilemmamedium", "Dilemmahard", "Meenemeneasy", "Meenemenmedium", "Meenemenhard", "Quickeasy", "Quickmedium", "Quickhard"]
    var categoryThree = ["Neeeasy", "Neemedium", "Neehard", "Kwaliteiteasy", "Kwaliteitmedium", "Kwaliteithard", "Karaktereasy", "Karaktermedium", "Karakterhard"]

    //var number = 0
    var PreviousButtonTitle = ""
    let userData = UserDefaults.standard.dictionary(forKey: "Games") as! [String : [String : [String : [String : Any]]]]
    var categoryArray = [String]()
    var gameAmount: Int?
    
    var difficultyNumber = 0
    var difficultyArray = ["easy", "medium", "hard"]
    var difficulty = ""
    
    var category = ""
    var buttonInfo = ""

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //this uses the info of the button on the previous page to correct
        gettingCorrectInfo(category: PreviousButtonTitle)
        print(userData["Categories"] ?? Dictionary())
        print("categorie: \(PreviousButtonTitle)")
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
        //this collects the names of the games that match each category
        switch category{
            case "Droom het" : categoryArray = Array(categoryUserData["Droom het"]!.keys)
            fillingCurrentLabel()
            for image in 0..<allImages.count{
                allImages[image].image = UIImage(named: categoryOne[image])
            }
            case "Speel het" : categoryArray = Array(categoryUserData["Speel het"]!.keys)
            fillingCurrentLabel()
            for image in 0..<allImages.count{
                allImages[image].image = UIImage(named: categoryTwo[image])
            }
            case "Doe het" : categoryArray = Array(categoryUserData["Doe het"]!.keys)
            fillingCurrentLabel()
            for image in 0..<allImages.count{
                allImages[image].image = UIImage(named: categoryThree[image])
            }
            default: categoryArray = Array(categoryUserData["Droom het"]!.keys)
        }
        print("CategorieArray: \(categoryArray)")
    }
    
    
    func fillingCurrentLabel(){
            //this is the array of difficulties
            //for each label do something
            for i in 0..<allButtons.count{
                //check if the difficulty that is used is true or false.
                let checkingBool = userData["Categories"]![PreviousButtonTitle]![categoryArray[difficultyNumber]]![difficultyArray[difficultyNumber]]! as! Bool
                
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
                }else{
                    difficultyNumber += 1
                }
            }
        }
    
    
    
    // if the game is playable
    func gameStateIsTrue(i: Int){
        allButtons[i].setTitle(difficultyArray[difficultyNumber], for: .normal)
        allButtons[i].setTitleColor(UIColor.green, for: .normal)
        allButtons[i].isEnabled = true
    }
    
    //if the game is not playable
    func gameStateIsFalse(i: Int){
        allButtons[i].setTitle(difficultyArray[difficultyNumber], for: .normal)
        allButtons[i].setTitleColor(UIColor.gray, for: .normal)
        allButtons[i].isEnabled = false
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
                performSegue(withIdentifier: "GameToMultiple", sender: self)
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


}
