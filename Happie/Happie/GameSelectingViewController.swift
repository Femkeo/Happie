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
    @IBOutlet var allLabels: [UILabel]!
    @IBOutlet var allLevelViews: [UIView]!
    @IBOutlet var allImages: [UIImageView]!
    

//    var categoryOne = ["Game1.0", "Game1.1", "Game1.2", "Game2.0", "Game2.1", "Game2.2", "Game3.0", "Game3.1", "Game3.2"]
//    var categoryTwo = ["Game4.0", "Game4.1", "Game4.2", "Game5.0", "Game5.1", "Game5.2", "Game6.0", "Game6.1", "Game6.2"]
//    var categoryThree = ["Game7.0", "Game7.1", "Game7.2", "Game8.0", "Game8.1", "Game8.2", "Game9.0", "Game9.1", "Game9.2"]

    //var number = 0

    
    var labelsOne = ["Raad de Tekening", "Wat is mijn droom?", "Foto-challenge"]
    
    var imagesOne = ["drawingGuessEasy","drawingGuessMedium","drawingGuessHard","dreamGuessEasy","dreamGuessMedium","dreamGuessHard","fotoChallengeEasy","fotoChallengeMedium","fotoChallengeHard"]

    var PreviousButtonTitle = ""
    let userData = UserDefaults.standard.dictionary(forKey: "Games") as! [String : [String : [String : [String : Any]]]]
    var categorieArray = [String]()
    var gameAmount: Int?
    
    var difficultyNumber = 0
    var difficultyArray = ["easy", "medium", "hard"]

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //this uses the info of the button on the previous page to correct
        gettingCorrectInfo(category: PreviousButtonTitle)
    }
    
    
    
    func gettingCorrectInfo(category: String){
        let categoryUserData = userData["Categories"] ?? Dictionary()
        //this collects the names of the games that match each category
        switch category{
            case "Droom het" : categorieArray = Array(categoryUserData["Droom het"]!.keys)
            fillingCurrentLabel()
            case "Speel het" : categorieArray = Array(categoryUserData["Speel het"]!.keys)
            fillingCurrentLabel()
            case "Doe het" : categorieArray = Array(categoryUserData["Doe het"]!.keys)
            fillingCurrentLabel()
            default: categorieArray = Array(categoryUserData["Droom het"]!.keys)

            gettingCorrectInfo()
        
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
        
        
    }

    }

    
    func fillingCurrentLabel(){

            
            //creating a number so we can count through the arrays of difficulties and categories
    
            //this is the array of difficulties
            //for each label do something
            for i in 0..<allButtons.count{
                //check if the difficulty that is used is true or false.
                let checkingBool = userData["Categories"]![PreviousButtonTitle]![categorieArray[difficultyNumber]]![difficultyArray[difficultyNumber]]! as! Bool
                
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


}
