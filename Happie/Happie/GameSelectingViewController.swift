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
    
    
    var categoryOne = ["Game1.0", "Game1.1", "Game1.2", "Game2.0", "Game2.1", "Game2.2", "Game3.0", "Game3.1", "Game3.2"]
    var categoryTwo = ["Game4.0", "Game4.1", "Game4.2", "Game5.0", "Game5.1", "Game5.2", "Game6.0", "Game6.1", "Game6.2"]
    var categoryThree = ["Game7.0", "Game7.1", "Game7.2", "Game8.0", "Game8.1", "Game8.2", "Game9.0", "Game9.1", "Game9.2"]
    
    var imagesOne = ["drawingGuessEasy","drawingGuessMedium","drawingGuessHard","dreamGuessEasy","dreamGuessMedium","dreamGuessHard","fotoChallengeEasy","fotoChallengeMedium","fotoChallengeHard"]

    var number = 0
    var imageNumber = 0
    var PreviousButtonTitle = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gettingCorrectInfo()
    }
    
    func gettingCorrectInfo(){
        if PreviousButtonTitle == "Button1"{
            for button in 0..<allButtons.count{
                allButtons[button].setTitle(categoryOne[number], for: .normal)
                number += 1
            }
            for image in 0..<allImages.count{
                allImages[image].image = UIImage(named: imagesOne[imageNumber])
                imageNumber += 1
            }
        }else if PreviousButtonTitle == "Button2"{
            for button in 0..<allButtons.count{
                allButtons[button].setTitle(categoryTwo[number], for: .normal)
                number += 1
            }
        }else if PreviousButtonTitle == "Button3"{
            for button in 0..<allButtons.count{
                allButtons[button].setTitle(categoryThree[number], for: .normal)
                number += 1
            }
        }
        
    }


}
