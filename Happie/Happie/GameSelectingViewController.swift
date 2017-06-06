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
    
//    var categoryOne = ["Game1.0", "Game1.1", "Game1.2", "Game2.0", "Game2.1", "Game2.2", "Game3.0", "Game3.1", "Game3.2"]
//    var categoryTwo = ["Game4.0", "Game4.1", "Game4.2", "Game5.0", "Game5.1", "Game5.2", "Game6.0", "Game6.1", "Game6.2"]
//    var categoryThree = ["Game7.0", "Game7.1", "Game7.2", "Game8.0", "Game8.1", "Game8.2", "Game9.0", "Game9.1", "Game9.2"]

    //var number = 0
    var PreviousButtonTitle = ""
    let userData = UserDefaults.standard.dictionary(forKey: "Games") as! [String : [String : [String : [String : Any]]]]
    var categorieArray = [String]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gettingCorrectInfo(category: PreviousButtonTitle)
    }
    
    
    
    func gettingCorrectInfo(category: String){
        let categoryUserData = userData["Categories"] ?? Dictionary()
        
        switch category{
            case "Droom het" : categorieArray = Array(categoryUserData["Droom het"]!.keys)
            fillingCurrentLabel()
            case "Speel het" : categorieArray = Array(categoryUserData["Speel het"]!.keys)
            fillingCurrentLabel()
            case "Doe het" : categorieArray = Array(categoryUserData["Doe het"]!.keys)
            fillingCurrentLabel()
            default: categorieArray = Array(categoryUserData["Droom het"]!.keys)
        }
        
    }
    
    func fillingCurrentLabel(){

            
            //creating a number so we can count through the arrays of difficulties and categories
            var difficultyNumber = 0
            //this is the array of difficulties
            var difficultyArray = ["easy", "medium", "hard"]
            //for each label do something
            for i in 0..<allButtons.count{
                //check if the difficulty that is used is true or false.
                let checkingBool = userData["Categories"]![PreviousButtonTitle]![categorieArray[difficultyNumber]]![difficultyArray[difficultyNumber]]! as! Bool
                //if its true set it to active
                if checkingBool == true{
                    allButtons[i].setTitle(difficultyArray[difficultyNumber], for: .normal)
                    allButtons[i].setTitleColor(UIColor.green, for: .normal)
                    allButtons[i].isEnabled = true
                    //if its false set it to inactive
                }else{
                    allButtons[i].setTitle(difficultyArray[difficultyNumber], for: .normal)
                    allButtons[i].setTitleColor(UIColor.gray, for: .normal)
                    allButtons[i].isEnabled = false
                }
                //start over if 2 was reached (for the arrays)
                if difficultyNumber == 2{
                    difficultyNumber = 0
                }else{
                    difficultyNumber += 1
                }
            }
        }


}
