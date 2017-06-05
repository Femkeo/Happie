//
//  CategoriesViewController.swift
//  Happie
//
//  Created by G.F Offringa on 29-05-17.
//  Copyright © 2017 femkeo. All rights reserved.
//

import UIKit

class CategoriesViewController: UIViewController {

    @IBOutlet var allButtons: [UIButton]!
    
    var Data = GameData()
    var userData = UserDefaults.standard.dictionary(forKey: "Games") ?? Dictionary()
    var rememberingButtonTitle = ""

    override func viewWillAppear(_ animated: Bool) {
        if UserDefaults.standard.bool(forKey: "launchedBefore") == true {
            Data.creatingGames()
            userData = UserDefaults.standard.dictionary(forKey: "Games") ?? Dictionary()
        }
        fillingLabels()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    
    @IBAction func CategorySelectionButtonAction(_ sender: UIButton) {
        rememberingButtonTitle = sender.currentTitle!
        performSegue(withIdentifier: "ToShowingCategory", sender: self)
    }
    
    
    func fillingLabels(){
        var number = 0
        
        let categoryUserData = userData["Categories"] as! [String: [String: Any]]
        
        var allCategories = Array(categoryUserData.keys)
        
        for label in 0..<allButtons.count{
            allButtons[label].setTitle(allCategories[number], for: .normal)
            number  += 1
        }
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ToShowingCategory" {
            let viewController = segue.destination as! GameSelectingViewController
            viewController.PreviousButtonTitle = rememberingButtonTitle

        }
    }


}
