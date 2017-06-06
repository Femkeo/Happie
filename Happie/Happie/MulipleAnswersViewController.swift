//
//  MulipleAnswersViewController.swift
//  Happie
//
//  Created by G.F Offringa on 06-06-17.
//  Copyright © 2017 femkeo. All rights reserved.
//

import UIKit

class MulipleAnswersViewController: UIViewController {

    
    @IBOutlet var buttons: [UIButton]!
    var previousCategory = ""
    var Reader = PropertyReader()

    var previousDifficulty = ""
    var number = 0
    
    
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
    
    @IBAction func buttonsAction(_ sender: Any) {
        if number != 9{
            number += 1
            for i in 0..<buttons.count {
                buttons[i].setTitle(Reader.pListDictResult["NewItem\(number)"]?[i], for: .normal)
            }
        }else{
            for i in 0..<buttons.count {
                buttons[i].backgroundColor = UIColor.clear
                buttons[i].setTitleColor(UIColor.black, for: .normal)
                buttons[i].layer.borderColor = UIColor.clear.cgColor
                buttons[i].isEnabled = false
                buttons[0].setTitle("Het maken van keuzes is moeilijk. Gelukkig kom je niet iedere dag de dilemma’s tegen die je zonet hebt moeten doorlopen. Je zult echter binnen het bereiken van dromen ook voor lastige keuzes komen te staan. Het is dan ook belangrijk om jezelf hierin te trainen. Sta je voor een moeilijke keuze? Praat er dan over, nieuwe inzichten kunnen het maken van een keuze veel gemakkelijker maken!", for: .normal)
                buttons[1].setTitle(" ", for: .normal)
                //ofLabel.text = ""
                //preferenceLabel.text = " "
                
            }
        }
    }
    

    
}
