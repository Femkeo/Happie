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
    
    
    @IBOutlet weak var skinImage: UIImageView!
    @IBOutlet weak var hairImage: UIImageView!
    @IBOutlet weak var clothesImage: UIImageView!
    @IBOutlet weak var avatarBackgroundImage: UIImageView!
    
    @IBOutlet weak var getStartedButton: UIButton!
    @IBOutlet weak var tutorialView: UIView!
    @IBOutlet weak var resetLaunchButton: UIButton!
    
    var first: Bool?
    var defaultAvatar = [
        "hair" : "Hair1",
        "skin" : "Skin1",
        "clothes" : "Clothes1",
        "dream" : "Vul hier je droom in"
    ]
    
    //this checks if the app has run before. If not, it shows a little tutorial view (ScreenViewController)
    let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
    
    override func viewWillAppear(_ animated: Bool) {
        
        //if the app has run before it will hide ScreenViewController (see bottom of page)
        if UserDefaults.standard.bool(forKey: "launchedBefore") == true {
            if tutorialView != nil{
                tutorialView.isHidden = true
            }
            
        }
        
        let images = [skinImage, hairImage, clothesImage, avatarBackgroundImage]
        
        //designstuff
        
        for image in images{
            image?.layer.cornerRadius = (image?.frame.size.width)!/2
            image?.clipsToBounds = true
            image?.layer.borderColor = UIColor.black.cgColor
            image?.layer.borderWidth = 2
        }
        
        getStartedButton.layer.cornerRadius = 20.0
        getStartedButton.layer.borderWidth = 1.5
        getStartedButton.layer.borderColor = UIColor.black.cgColor
        
        dreamNameLabel.adjustsFontSizeToFitWidth = true
        dreamNameLabel.numberOfLines = 2
        dreamNameLabel.minimumScaleFactor = 0.2
        
        //end designstuff
        
        if UserDefaults.standard.dictionary(forKey: "SettingsDict")?["hair"] == nil{
            UserDefaults.standard.set(defaultAvatar, forKey: "SettingsDict")
        }
        
        hairImage.image = UIImage(named: UserDefaults.standard.dictionary(forKey: "SettingsDict")?["hair"] as? String ?? String())
        skinImage.image = UIImage(named: UserDefaults.standard.dictionary(forKey: "SettingsDict")?["skin"] as? String ?? String())
        clothesImage.image = UIImage(named: UserDefaults.standard.dictionary(forKey: "SettingsDict")?["clothes"] as? String ?? String())
        dreamNameLabel.text = UserDefaults.standard.dictionary(forKey: "SettingsDict")?["dream"] as? String ?? String()
    }//end viewWillAppear
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UserDefaults.standard.bool(forKey: "launchedBefore") == true {
        }else{
            dreamNameLabel.isHidden = true
            hairImage.isHidden = true
            skinImage.isHidden = true
            clothesImage.isHidden = true
            getStartedButton.isHidden = true
            resetLaunchButton.isHidden = true
        }
    }
    

    

    func close() {
        tutorialView.isHidden = true
        dreamNameLabel.isHidden = false
        hairImage.isHidden = false
        skinImage.isHidden = false
        clothesImage.isHidden = false
        getStartedButton.isHidden = false
        resetLaunchButton.isHidden = false
        self.navigationController?.setNavigationBarHidden(false, animated: true)

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

