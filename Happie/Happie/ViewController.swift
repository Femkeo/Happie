//
//  ViewController.swift
//  Happie
//
//  Created by G.F Offringa on 29-05-17.
//  Copyright © 2017 femkeo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ContainerDelegateProtocol {
    
    
    @IBOutlet weak var dreamNameLabel: UILabel!
    @IBOutlet weak var avatarBodyLabel: UIImageView!
    @IBOutlet weak var getStartedButton: UIButton!
    @IBOutlet weak var tutorialView: UIView!
    @IBOutlet weak var resetLaunchButton: UIButton!
    
    //this checks if the app has run before. If not, it shows a little tutorial view (ScreenViewController)
    let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
    
    override func viewWillAppear(_ animated: Bool) {
        
        //this makes the navigationcontroller hide on this page.
        self.navigationController?.setNavigationBarHidden(true, animated: true)

        
        //if the app has run before it will hide ScreenViewController (see bottom of page)
        if UserDefaults.standard.bool(forKey: "launchedBefore") == true {
            if tutorialView != nil{
                tutorialView.isHidden = true
            }
        }
    }//end viewWillAppear
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDefaults.standard.bool(forKey: "launchedBefore") == true {
        }else{
            dreamNameLabel.isHidden = true
            avatarBodyLabel.isHidden = true
            getStartedButton.isHidden = true
            resetLaunchButton.isHidden = true
            
        }

    }

    func close() {
        tutorialView.isHidden = true
        dreamNameLabel.isHidden = false
        avatarBodyLabel.isHidden = false
        getStartedButton.isHidden = false
        resetLaunchButton.isHidden = false
    }
    
    func hideStuff(buttonPressed: Bool){
        self.tutorialView.isHidden = true
    }
    
    //Sending info to different ViewControllers
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Cardpage
        if segue.identifier == "FirstLaunchContainer"{
            (segue.destination as! FirstLaunchViewController).delegate = self;
        }
    }
    
    //by uncommenting this, you can link this to a button to make the app think it hasnt been launched before
        @IBAction func Testbutton(_ sender: Any) {
            UserDefaults.standard.set(false, forKey: "launchedBefore")
        }


}

