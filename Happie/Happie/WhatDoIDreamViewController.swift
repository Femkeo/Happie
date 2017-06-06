//
//  WhatDoIDreamViewController.swift
//  Happie
//
//  Created by G.F Offringa on 06-06-17.
//  Copyright © 2017 femkeo. All rights reserved.
//

import UIKit

class WhatDoIDreamViewController: UIViewController {

    @IBOutlet weak var passDeficeButton: UIButton!
    @IBOutlet weak var showDreamLabel: UILabel!
    
    
    var currentDream: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showDreamLabel.text = "Geef de telefoon aan de persoon die zijn of haar droom moet raden en laat die persoon het scherm indrukken wanneer deze hem tegen het hoofd heeft"
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func passDeficeButtonAction(_ sender: Any) {
        passDeficeButton.isEnabled = false
        showDreamLabel.text = currentDream
    }
    


}
