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
    
    @IBOutlet weak var stepsLabel: UILabel!
    @IBOutlet weak var userProgressOutlet: UIProgressView!
    
    var currentProgress = 0.0
    var first: Bool?
    var Data = UserData()
    
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
        
        //end designstuff
        
        Data.creatingUserData()
        
        hairImage.image = UIImage(named: UserDefaults.standard.dictionary(forKey: "SettingsDict")?["hair"] as? String ?? String())
        skinImage.image = UIImage(named: UserDefaults.standard.dictionary(forKey: "SettingsDict")?["skin"] as? String ?? String())
        clothesImage.image = UIImage(named: UserDefaults.standard.dictionary(forKey: "SettingsDict")?["clothes"] as? String ?? String())
        dreamNameLabel.text = UserDefaults.standard.dictionary(forKey: "SettingsDict")?["dream"] as? String ?? String()
        userProgressOutlet.progress = UserDefaults.standard.dictionary(forKey: "SettingsDict")?["userScore"] as? Float ?? Float()
        settingScore()
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
    
    
    
    func settingScore(){
        let currentUserScore = UserDefaults.standard.dictionary(forKey: "SettingsDict")?["userScore"] as? Float ?? Float()
        if currentUserScore <= 100.0{
            stepsLabel.text = "Zet 100 stappen"
        }else if currentUserScore <= 200{
            stepsLabel.text = "Je hebt al 100 stappen gezet! Probeer eens 200 te zetten!"
        }else if currentUserScore <= 300{
            stepsLabel.text = "Je heb al 200 stappen gezet! 300 moet nu geen probleem meer zijn voor jou!"
        }else{
            stepsLabel.text = "Je hebt al zoveel stappen gezet! Het is net of ben je een rondje om de wereld geweest!"
        }
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

