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
    @IBOutlet var allViews: [UIView]!
    @IBOutlet var allBackgroundImages: [UIImageView]!
    @IBOutlet var categorieLabels: [UILabel]!
    
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
        
        for view in allViews{
            view.layer.cornerRadius = 15.0
        }
        
        for image in allBackgroundImages{
            image.layer.cornerRadius = 15.0
            image.layer.masksToBounds = true
        }
        
        for label in categorieLabels{
            label.numberOfLines = 1;
            label.minimumScaleFactor = 49./label.font.pointSize;
            label.adjustsFontSizeToFitHeight = YES;
        }

    }

    
    @IBAction func CategorySelectionButtonAction(_ sender: UIButton) {
        rememberingButtonTitle = sender.currentTitle!
        print(sender.currentTitle!)
        print("heey")
        performSegue(withIdentifier: "ToShowingCategory", sender: self)
    }
    
    
    func fillingLabels(){
        var number = 0
        
        let categoryUserData = userData["Categories"] as! [String: [String: Any]]
        
        var allCategories = Array(categoryUserData.keys)
        let element = allCategories.remove(at: 1)
        allCategories.insert(element, at: 0)
        print(allCategories)
        
        for label in 0..<allButtons.count{
            allButtons[label].setTitle(allCategories[number], for: .normal)
            print(allCategories[number])
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
