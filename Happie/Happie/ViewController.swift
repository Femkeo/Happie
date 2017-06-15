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
        //getting all the needed design settings
        settingDesign()
        
        //creating userdata controlled by the model UserData
        Data.creatingUserData()
        
        //this fills the labels and images with the correct data collected from data
        hairImage.image = UIImage(named: UserDefaults.standard.dictionary(forKey: "SettingsDict")?["hair"] as? String ?? String())
        skinImage.image = UIImage(named: UserDefaults.standard.dictionary(forKey: "SettingsDict")?["skin"] as? String ?? String())
        clothesImage.image = UIImage(named: UserDefaults.standard.dictionary(forKey: "SettingsDict")?["clothes"] as? String ?? String())
        dreamNameLabel.text = UserDefaults.standard.dictionary(forKey: "SettingsDict")?["dream"] as? String ?? String()
        
        //this checks if the user filled in a dream by checking for defaulttext. If not the default text is replaced.
        if dreamNameLabel.text == "Vul hier je droom in"{
            dreamNameLabel.text = "Hey jij! Je bent vergeten je droom in te vullen!"
        }
        //this checks for either old or new userScores, to show the user progress
        settingScore()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //if the app has never launched before, hide all the items of this viewcontroller
        if UserDefaults.standard.bool(forKey: "launchedBefore") == true {
        }else{
            dreamNameLabel.isHidden = true
            hairImage.isHidden = true
            skinImage.isHidden = true
            clothesImage.isHidden = true
            getStartedButton.isHidden = true
        }
    }
    
    
    
    //this make all the items repear after launchedbefore is set to true
    func close() {
        tutorialView.isHidden = true
        dreamNameLabel.isHidden = false
        hairImage.isHidden = false
        skinImage.isHidden = false
        clothesImage.isHidden = false
        getStartedButton.isHidden = false
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    //this hides the tutorialview
    func hideStuff(buttonPressed: Bool){
        self.tutorialView.isHidden = true
    }
    
    
    
    //this checks the usersscore
    func settingScore(){
        //this makes sure it doesnt search for data when it ist yet loaded
        if UserDefaults.standard.bool(forKey: "launchedBefore") == true{
            //this stores an array of the ranks that van be achieved.
            var scoreArray: [Float] = [25.0, 100.0, 250.0, 500.0, 1000.0, 1500.0, 2000.0]
            //this gets the score the user already has
            let currentUserScore: Float = UserDefaults.standard.dictionary(forKey: "SettingsDict")?["userScore"] as? Float ?? Float()
            //this sets variables for either the tarscore or the startingscore, which means the rank the user is.
            var targetScore: Float = 25.0
            var startingScore: Float = 25.0
            //this checks all the items in the scoreArray to see which rank the user is.
            for score in 0..<scoreArray.count{
                //if the user score is lower then the array, fill in data to search for the rank.
                if currentUserScore > scoreArray[score]{
                    targetScore = scoreArray[score + 1]
                    startingScore = scoreArray[score]
                }
            }
            
            //makes a variable wich van be used to save currentprogress.
            //set its value a percentage. (score devided by target)
            var currentProgress: Float = currentUserScore / targetScore
            //if the user has reached the top of the targetscore. Make the target the next level.
            if currentProgress == 1.0{
                if let index = scoreArray.index(of: targetScore){
                    targetScore = scoreArray[index + 1]
                    currentProgress = currentUserScore / targetScore
                }
            }
            //fill the progressbar with the current progress made by the user
            userProgressOutlet.progress = currentProgress
            
            //let the label give feedback on what the user has already achieved.
            switch startingScore{
            case 25.0 : stepsLabel.text = "Je hebt je eerste stappen gezet! Houd hier in de gaten hoever je al opweg bent!"
            case 100.0: stepsLabel.text = "Je bent 100 steppen dichterbij je droom!"
            case 250.0 : stepsLabel.text = "Je bent 250 stappen dichterbij je droom!"
            case 1000.0 : stepsLabel.text = "Je bent 1000 stappen dichterbij je droom!"
            case 1500.0: stepsLabel.text = "Je bent 1500 stappen dichterbij je droom!"
            case 2000.0: stepsLabel.text = "Je bent 2000 stappen dichterbij je droom!"
            case 3000.0: stepsLabel.text = "Je bent 3000 stappen dichterbij je droom!"
            case 1000000000000.0: stepsLabel.text = "Je bent echt aan een nieuwe droom beginnen!"
            default: stepsLabel.text = "Je hebt je eerste stappen gezet! houd hier in de gaten hoever je al opweg"
            }
        }
    }
    
    
    
    func settingDesign(){
        //this makes the avatar images rond
        for image in images{
            image.layer.cornerRadius = (image.frame.size.width)/2
            image.clipsToBounds = true
            image.layer.borderColor = UIColor.black.cgColor
            image.layer.borderWidth = 2
        }
        
        //this controls how the get started button looks of the firstlaunchview
        getStartedButton.layer.cornerRadius = 20.0
        getStartedButton.layer.borderWidth = 1.5
        getStartedButton.layer.borderColor = UIColor.black.cgColor
        
        //this makes the label texts scalable
        dreamNameLabel.adjustsFontSizeToFitWidth = true
        dreamNameLabel.numberOfLines = 2
        dreamNameLabel.minimumScaleFactor = 0.2
        
        stepsLabel.adjustsFontSizeToFitWidth = true
        stepsLabel.numberOfLines = 50
        stepsLabel.minimumScaleFactor = 0.2
        
        //this gives the progressbar a nice colour.
        userProgressOutlet.tintColor =  UIColor(red: 220/255, green: 45/255, blue: 66/255, alpha: 1.0)
    }
    
    //Getting info from FirstLaunchContainer
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Cardpage
        if segue.identifier == "FirstLaunchContainer"{
            (segue.destination as! FirstLaunchViewController).delegate = self;
        }
    }
    
    
    //by uncommenting this, you can link this to a button to make the app think it hasnt been launched before
//        @IBAction func Testbutton(_ sender: Any) {
//            UserDefaults.standard.set(false, forKey: "launchedBefore")
//        }


}

