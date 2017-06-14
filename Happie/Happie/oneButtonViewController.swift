//
//  oneButtonViewController.swift
//  Happie
//
//  Created by G.F Offringa on 06-06-17.
//  Copyright © 2017 femkeo. All rights reserved.
//

import UIKit

class oneButtonViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    //all the outlets
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var descriptionView: UIView!
    
    //all the variables
    var difficultyArray = ["easy", "medium", "hard"]
    var gameFromPrevious = ""
    var difficultyFromPrevious = ""
    var gameCategory = ""
    var nextDifficulty = ""
    var hasLoadedBefore = false
    var number = 0
    
    //this collects the saved data from userdefaults
    var gameData = UserDefaults.standard.dictionary(forKey: "Games") as! [String : [String : [String : [String : Any]]]]
    var userData = UserDefaults.standard.dictionary(forKey: "SettingsDict") ?? Dictionary()
    //this import a model to keep track of someone saying "Nee"
    var Yes = YesSayer()

    
    override func viewWillAppear(_ animated: Bool) {
        //check which difficulty should be loaded. This data is not yet used.
        checkingDifficulties()
        //checking which game or info to load
        checkingGameCategory(game: gameFromPrevious)
        //this fills everything with the data
        provideCorrectInfo()
        //getting the design right
        settingDesign()
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    //this does the right thing depending on which game is selected
    @IBAction func startAction(_ sender: Any) {
        switch gameFromPrevious{
        case "Raad mijn droom":
            performSegue(withIdentifier: "OneToTableView", sender: self)
        case "Wat is mijn karakter":
            performSegue(withIdentifier: "OneToTableView", sender: self)
        case "Quick quiz":
            performSegue(withIdentifier: "OneToQuiz", sender: self)
        case "Kwaliteiten quiz":
            performSegue(withIdentifier: "OneToQuiz", sender: self)
        case "Raad de tekening":
            performSegue(withIdentifier: "OneToDraw", sender: self)
        case "Dilemma's":
            performSegue(withIdentifier: "OneToMultiple", sender: self)
        case "Welja, geen nee":
            print("no game is true")
            alert()
            startButton.setTitle("In process", for: .normal)
            startButton.isEnabled = false
        case "Ik heb een droom en ik neem mee" :
            startButton.isHidden = true
            startButton.isEnabled = true
            descriptionLabel.text = "Ik heb een droom en ik neem mee..."
        case "Foto challenge":
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = UIImagePickerControllerSourceType.camera;
                imagePicker.allowsEditing = false
                self.present(imagePicker, animated: true, completion: nil)
                saveButton.tintColor = UIColor.black
            }
        default: break
        }
    }
    
    //if the photos game is played that photo can be saved.
    @IBAction func saveButtonAction(_ sender: Any) {
        if self.photoImage.image == nil{
            return
        }
        UIImageWriteToSavedPhotosAlbum(self.photoImage.image!,self, #selector(imageAlert(_:withPotentialError:contextInfo:)), nil)
       
    }
    
    //if the user is done, data is saved and the unwindsegue is activated.
    @IBAction func doneButtonAction(_ sender: Any) {
        savingAndGoingBack()
    }
    
    
    
    //if the photosgame is played, the photo will be shown, were the text used to be
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        photoImage.image = image
        descriptionLabel.text = ""
        startButton.setTitle("Opnieuw", for: .normal)
        saveButton.isEnabled = true
        self.dismiss(animated: true, completion: nil);
    }
    
    
    //this gets the correct info, depending of the game that is going to be played.
    func provideCorrectInfo(){
        switch gameFromPrevious{
        case "Raad mijn droom":
            descriptionLabel.text = "Denk je dat ‘Wie ben ik’ lastig is? Probeer dan eens ‘Wat droom ik?’, voor wie van een echte uitdagingen houdt!"
            
        case "Wat is mijn karakter":
            descriptionLabel.text = " Vraag iemand om 5 karaktereigenschappen voor jou uit te kiezen. Kijk ook gerust of dat overeenkomt met wat je zelf zou invullen!"
            
        case "Quick quiz":
            descriptionLabel.text = "Je hebt 20 seconden de tijd om zoveel mogelijk vragen te beantwoorden. Tik tak tik tak, tempo."
            
        case "Kwaliteiten quiz":
            descriptionLabel.text = "Check met deze quiz of je partner-in-crime dezelfde kwaliteiten in jou ziet als dat je dat zelf doet."
            
        case"Foto challenge" : descriptionLabel.text = "Maak een foto die jouw droom omschrijft. Je mag items gebruiken, mensen, omgevingen, wees creatief!. Vraag eens aan anderen of ze je droom erin herkennen."
        saveButton.tintColor = UIColor.gray
            
        case "Welja, geen nee" :
            descriptionLabel.text = "NEEgativiteit staat tussen jou en je droom in. Hoe los je dit op? Door gewoon lekker ja te zeggen, word je blij van. Bonus: Het brengt je droom een beetje (of heel veel) dichterbij. Wil je toch?"
            
        case "Ik heb een droom en ik neem mee":
            descriptionLabel.text = "Ik ga op reis en ik neem mee, maar dan met dromen! Wat heb jij nodig om jouw droom te kunnen realiseren? "
            
        case "Dilemma's":
            descriptionLabel.text = "Heb je moeite met keuzes maken? Dan heb je deze dilemma’s nog niet gelezen. Oefen hier eens mee, dan worden je eigen dilemma’s makkelijker op te lossen!"
            
        case "Raad de tekening":
            descriptionLabel.text = "Teken een element dat betrekking heeft op jouw droom. Laat tijdens het tekenen je vrienden raden wat het wordt!"
            
            default: break
        }
    }
    
    
    //this collects the category the game belongs to, so data can be collected easily
    func checkingGameCategory(game: String){
        let droomGames = Array(gameData["Categories"]!["Droom het"]!.keys)
        let speelGames = Array(gameData["Categories"]!["Speel het"]!.keys)
        let doeGames = Array(gameData["Categories"]!["Doe het"]!.keys)
        
        if droomGames.contains(game){
            gameCategory = "Droom het"
        }else if speelGames.contains(game){
            gameCategory = "Speel het"
        }else if doeGames.contains(game){
            gameCategory = "Doe het"
        }
    }
    
    
    //this checks which difficulty the users wants to play, depending on the button pressed at the previous ViewController. The different levels are not implemented yet.
    func checkingDifficulties(){
        let indexOfDifficulty = difficultyArray.index(of: difficultyFromPrevious)
        if indexOfDifficulty == 2{
            nextDifficulty = difficultyFromPrevious
        }else{
            nextDifficulty = difficultyArray[indexOfDifficulty! + 1]
        }
    }
    
    
    //this saved data and activates going back segue.
    func savingAndGoingBack(){
        //activate this segue
        self.performSegue(withIdentifier: "BackToStartFromOne", sender: self)
        if gameFromPrevious == "Foto challenge"{
            //get the score that the user has earned from playing.
            updateScore()
            
            //add to the counter of the current game
            var newCounterValue = 0
            let counter = gameData["Categories"]![gameCategory]![gameFromPrevious]!["counter"]! as! Int
            newCounterValue = counter + 1
            
            //see what data needs to be update and give it a adaptable Dictionary value.
            let dataToUpdate = GameData()
            dataToUpdate.creatingGames()
            var newData = dataToUpdate.result
            
            
            //unluck new category if earned.
            newData["Categories"]![gameCategory]![gameFromPrevious]![nextDifficulty]! = true
            
            
            //add to saved counter
            newData["Categories"]![gameCategory]![gameFromPrevious]!["counter"] = newCounterValue
            
            
            //save all the above and all the original data in userdefault"Games"
            UserDefaults.standard.set(newData, forKey: "Games")
        }
        
    }
    
    
    
    //update the score of the user
    func updateScore(){
        //create a variable for the newscore
        var newScoreValue: Float = 0.0
        //get the already earned score
        let score = userData["userScore"] as! Float
        
        //add up depending on which difficulty is played
        switch difficultyFromPrevious{
        case "easy" : newScoreValue = 50
        case "medium" : newScoreValue = 100
        case "hard" : newScoreValue = 150
        default: newScoreValue = 50
        }
        newScoreValue += score
        
        //collect the data that needs to be update and make it adaptable
        let dataToUpdate = UserData()
        dataToUpdate.creatingUserData()
        var newData = dataToUpdate.result
        
        //add the new data where the score is saved
        newData["userScore"] = newScoreValue
        
        //resave the data to the userdefault "SettingsDict"
        UserDefaults.standard.set(newData, forKey: "SettingsDict")
        
    }
    
    
    
    //getting the design right
    func settingDesign(){
        saveButton.tintColor = UIColor.clear
        saveButton.isEnabled = false
        
        startButton.setTitle("Start!", for: .normal)
        
        startButton.layer.cornerRadius = 20.0
        startButton.layer.borderWidth = 1.5
        startButton.layer.borderColor = UIColor.black.cgColor
        
        descriptionView.layer.cornerRadius = 20.0
        
        descriptionLabel.adjustsFontSizeToFitWidth = true
        descriptionLabel.minimumScaleFactor = 0.2
        descriptionLabel.numberOfLines = 50

    }

    
    
    //this starts an alart depending on which game is played.
    func alert(){
        Yes.countingTillEnding()
        let alert =  UIAlertController(title: nil, message: "Je mag nu een minuut geen nee meer zeggen!", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(OKAction)
        self.present(alert, animated: true)
    }
    
    func imageAlert(_ image: UIImage, withPotentialError error: NSErrorPointer, contextInfo: UnsafeRawPointer){
        let alert =  UIAlertController(title: nil, message: "Je foto is succesvol opgeslagen!", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(OKAction)
        self.present(alert, animated: true)
    }
    
    
    
    //if this ViewController was purely for information showing, segue to their ViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "OneToOne" {
            let viewController = segue.destination as! oneButtonViewController
            viewController.difficultyFromPrevious = difficultyFromPrevious
            viewController.gameFromPrevious = gameFromPrevious
        }
        if segue.identifier == "OneToDraw" {
            let viewController = segue.destination as! drawingViewController
            viewController.difficultyFromPrevious = difficultyFromPrevious
            viewController.gameFromPrevious = gameFromPrevious

        }
        if segue.identifier == "OneToMultiple" {
            let viewController = segue.destination as! MulipleAnswersViewController
            viewController.difficultyFromPrevious = difficultyFromPrevious
            viewController.gameFromPrevious = gameFromPrevious

        }
        if segue.identifier == "OneToTableView" {
            let viewController = segue.destination as! TableViewController
            viewController.difficultyFromPrevious = difficultyFromPrevious
            viewController.gameFromPrevious = gameFromPrevious
        }
        if segue.identifier == "OneToQuiz" {
            let viewController = segue.destination as! QuizViewController
            viewController.difficultyFromPrevious = difficultyFromPrevious
            viewController.gameFromPrevious = gameFromPrevious
        }
    }




}
