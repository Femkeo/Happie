//
//  CategoriesViewController.swift
//  Happie
//
//  Created by G.F Offringa on 29-05-17.
//  Copyright © 2017 femkeo. All rights reserved.
//

import UIKit

class CategoriesViewController: UIViewController {

    //all the outlets
    @IBOutlet var allButtons: [UIButton]!
    @IBOutlet var allViews: [UIView]!
    @IBOutlet var allBackgroundImages: [UIImageView]!
    @IBOutlet var categorieLabels: [UILabel]!
    @IBOutlet var categoryImages: [UIImageView]!
    
    //all the variables
    var Data = GameData()
    var userData = UserDefaults.standard.dictionary(forKey: "Games") ?? Dictionary()
    var rememberingButtonTitle = ""

    
    //load data and use the saved data to fill labels
    override func viewWillAppear(_ animated: Bool) {
        if UserDefaults.standard.bool(forKey: "launchedBefore") == true {
            Data.creatingGames()
            userData = UserDefaults.standard.dictionary(forKey: "Games") ?? Dictionary()
        }
        fillingLabels()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingDesign()
    }

    
    //remember the title of the button the user presses, so it can be used to load the next ViewController.
    @IBAction func CategorySelectionButtonAction(_ sender: UIButton) {
        rememberingButtonTitle = sender.currentTitle!
        performSegue(withIdentifier: "ToShowingCategory", sender: self)
    }
    
    
    //filling the labels with the correct names of the categories
    func fillingLabels(){
        
        let categoryUserData = userData["Categories"] as! [String: [String: Any]]
        
        var allCategories = Array(categoryUserData.keys)
        let element = allCategories.remove(at: 1)
        allCategories.insert(element, at: 0)
        print(allCategories)
        
        for label in 0..<allButtons.count{
            allButtons[label].setTitle(allCategories[label], for: .normal)
            categoryImages[label].image = UIImage(named: allCategories[label])
            categorieLabels[label].text = "\(allCategories[label])"
        }
    }
    
    //designing all the buttons etc
    func settingDesign(){
        for view in allViews{
            view.layer.cornerRadius = 15.0
        }
        
        for image in allBackgroundImages{
            image.layer.cornerRadius = 15.0
            image.layer.masksToBounds = true
            
        }
        
        for label in categorieLabels{
            label.adjustsFontSizeToFitWidth = true
            label.minimumScaleFactor = 0.2
            label.numberOfLines = 0;
        }
    }
    
    //pass on the name of the pressed button, so the next ViewController can use that information. 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ToShowingCategory" {
            let viewController = segue.destination as! GameSelectingViewController
            viewController.PreviousButtonTitle = rememberingButtonTitle

        }
    }


}
