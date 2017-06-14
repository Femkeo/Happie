//
//  ViewController.swift
//  Happie
//
//  Created by G.F Offringa on 29-05-17.
//  Copyright © 2017 femkeo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ContainerDelegateProtocol {
    //all the outlets set from userData
    @IBOutlet weak var dreamNameLabel: UILabel!
    @IBOutlet weak var skinImage: UIImageView!
    @IBOutlet weak var hairImage: UIImageView!
    @IBOutlet weak var clothesImage: UIImageView!
    @IBOutlet var images: [UIImageView]!
    //background outlet
    @IBOutlet weak var avatarBackgroundImage: UIImageView!
    //functional outlets
    @IBOutlet weak var getStartedButton: UIButton!
    @IBOutlet weak var tutorialView: UIView!
    @IBOutlet weak var resetLaunchButton: UIButton!
    //progress outlets
    @IBOutlet weak var stepsLabel: UILabel!
    @IBOutlet weak var userProgressOutlet: UIProgressView!
    //importing the UserData model
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
        //designstuff
        for image in images{
            image.layer.cornerRadius = (image.frame.size.width)/2
            image.clipsToBounds = true
            image.layer.borderColor = UIColor.black.cgColor
            image.layer.borderWidth = 2
        }
        
        getStartedButton.layer.cornerRadius = 20.0
        getStartedButton.layer.borderWidth = 1.5
        getStartedButton.layer.borderColor = UIColor.black.cgColor
        
        dreamNameLabel.adjustsFontSizeToFitWidth = true
        dreamNameLabel.numberOfLines = 2
        dreamNameLabel.minimumScaleFactor = 0.2
        
        stepsLabel.adjustsFontSizeToFitWidth = true
        stepsLabel.numberOfLines = 50
        stepsLabel.minimumScaleFactor = 0.2
        
        //end designstuff
        
        Data.creatingUserData()
        
        hairImage.image = UIImage(named: UserDefaults.standard.dictionary(forKey: "SettingsDict")?["hair"] as? String ?? String())
        skinImage.image = UIImage(named: UserDefaults.standard.dictionary(forKey: "SettingsDict")?["skin"] as? String ?? String())
        clothesImage.image = UIImage(named: UserDefaults.standard.dictionary(forKey: "SettingsDict")?["clothes"] as? String ?? String())
        dreamNameLabel.text = UserDefaults.standard.dictionary(forKey: "SettingsDict")?["dream"] as? String ?? String()
        if dreamNameLabel.text == "Vul hier je droom in"{
            dreamNameLabel.text = "Hey jij! Je bent vergeten je droom in te vullen!"
        }
        userProgressOutlet.progress = UserDefaults.standard.dictionary(forKey: "SettingsDict")?["userScore"] as? Float ?? Float()
        settingScore()
    }
    
    
    
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
        if UserDefaults.standard.bool(forKey: "launchedBefore") == true{
            var scoreArray: [Float] = [25.0, 100.0, 250.0, 500.0, 1000.0, 1500.0, 2000.0]
            
            let currentUserScore: Float = UserDefaults.standard.dictionary(forKey: "SettingsDict")?["userScore"] as? Float ?? Float()
            var targetScore: Float = 25.0
            var startingScore: Float = 25.0
            print(currentUserScore)
            for score in 0..<scoreArray.count{
                print("heey")
                if currentUserScore > scoreArray[score]{
                    targetScore = scoreArray[score + 1]
                    startingScore = scoreArray[score]
                    print("hoi")
                }
            }

            var currentProgress: Float = 1.0
            print(targetScore)
            if targetScore == 0.0{
                currentProgress = 1.0
            }else{
                currentProgress = currentUserScore / targetScore
                if currentProgress == 1.0{
                    if let index = scoreArray.index(of: targetScore){
                        targetScore = scoreArray[index + 1]
                        currentProgress = currentUserScore / targetScore
                    }
                }
            }
            print(currentProgress)

            
            userProgressOutlet.progress = currentProgress
            userProgressOutlet.tintColor =  UIColor(red: 220/255, green: 45/255, blue: 66/255, alpha: 1.0)
            
            switch startingScore{
            case 25.0 : stepsLabel.text = "Je hebt je eerste stappen gezet! Houd hier in de gaten hoever je al opweg bent!"
            case 100.0: stepsLabel.text = "Je hebt de 100 stappen bereikt! Dat is hetzelfde twee baantjes in een zwembad!"
            case 250.0 : stepsLabel.text = "Je hebt 250 stappen gezet! Daarmee kom je zo hoog als de hoogste wolkenkrabber van Spanje!"
            case 500: stepsLabel.text = "Hoppa, 500 stappen alweer! Knap hoor!"
            case 1000.0 : stepsLabel.text = "1000 stappen alweer! En zo te zien bruis je nog van de energie!"
            case 1500.0: stepsLabel.text = "Anderhalve kilometer! poeh poeh!"
            case 2000.0: stepsLabel.text = "Wauw! 2000 stappen heb je gezet!"
            case 3000.0: stepsLabel.text = "Je bent echt een expert op het gebied van dromen laten uitkomen!"
            default: stepsLabel.text = "Je hebt je eerste stappen gezet! houd hier in de gaten hoever je al opweg"
            }
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

