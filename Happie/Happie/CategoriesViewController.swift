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
    
    var rememberingButtonTitle = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    
    @IBAction func CategorySelectionButtonAction(_ sender: UIButton) {
        rememberingButtonTitle = sender.currentTitle!
        performSegue(withIdentifier: "ToShowingCategory", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ToShowingCategory" {
            let viewController = segue.destination as! GameSelectingViewController
            viewController.PreviousButtonTitle = rememberingButtonTitle

        }
    }


}
