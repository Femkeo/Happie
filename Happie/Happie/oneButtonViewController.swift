//
//  oneButtonViewController.swift
//  Happie
//
//  Created by G.F Offringa on 06-06-17.
//  Copyright © 2017 femkeo. All rights reserved.
//

import UIKit

class oneButtonViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var difficultyArray = ["easy", "medium", "hard"]
    var previousCategory = ""
    var previousDifficulty = ""
    var nextDifficulty = ""

    var Yes = YesSayer()
    var hasLoadedBefore = false
    var number = 0
    
    var userData = UserDefaults.standard.dictionary(forKey: "Games") as! [String : [String : [String : [String : Any]]]]

    
    
    override func viewWillAppear(_ animated: Bool) {
        let indexOfDifficulty = difficultyArray.index(of: previousDifficulty)
        if indexOfDifficulty == 2{
        }else{
            nextDifficulty = difficultyArray[indexOfDifficulty! + 1]
        }

    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        provideCorrectInfo()
        saveButton.tintColor = UIColor.clear
        saveButton.isEnabled = false
        
        startButton.layer.cornerRadius = 7.0
        startButton.layer.borderWidth = 2.0
        startButton.layer.borderColor = UIColor.black.cgColor

    }
    
    @IBAction func startAction(_ sender: Any) {
        switch previousCategory{
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
    
    
    @IBAction func saveButtonAction(_ sender: Any) {
        if self.photoImage.image == nil{
            return
        }
        UIImageWriteToSavedPhotosAlbum(self.photoImage.image!,self, #selector(imageAlert(_:withPotentialError:contextInfo:)), nil)
       
    }
    
    @IBAction func doneButtonAction(_ sender: Any) {
        self.performSegue(withIdentifier: "BackToStartFromOne", sender: self)
        var newCounterValue = 0
        
        if previousCategory == "Foto challenge"{
            let counter = userData["Categories"]!["Droom het"]![previousCategory]!["counter"]! as! Int
            newCounterValue = counter + 1
            
            let dataToUpdate = GameData()
            dataToUpdate.creatingGames()
            var newData = dataToUpdate.result
            
            newData["Categories"]!["Droom het"]![previousCategory]![nextDifficulty]! = true
            newData["Categories"]!["Droom het"]![previousCategory]!["counter"] = newCounterValue
            
            UserDefaults.standard.set(newData, forKey: "Games")
        }else if previousCategory == "Welja, geen nee"{
            let counter = userData["Categories"]!["Doe het"]![previousCategory]!["counter"]! as! Int
            newCounterValue = counter + 1
            
            let dataToUpdate = GameData()
            dataToUpdate.creatingGames()
            var newData = dataToUpdate.result
            
            newData["Categories"]!["Doe het"]![previousCategory]![nextDifficulty]! = true
            newData["Categories"]!["Doe het"]![previousCategory]!["counter"] = newCounterValue
            
            UserDefaults.standard.set(newData, forKey: "Games")
        }else if previousCategory == "Ik heb een droom en ik neem mee"{
            let counter = userData["Categories"]!["Speel het"]![previousCategory]!["counter"]! as! Int
            newCounterValue = counter + 1
            
            let dataToUpdate = GameData()
            dataToUpdate.creatingGames()
            var newData = dataToUpdate.result
            
            newData["Categories"]!["Speel het"]![previousCategory]![nextDifficulty]! = true
            newData["Categories"]!["Speel het"]![previousCategory]!["counter"] = newCounterValue
            
            UserDefaults.standard.set(newData, forKey: "Games")
        }
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        photoImage.image = image
        saveButton.isEnabled = true
        self.dismiss(animated: true, completion: nil);
    }
    
    func provideCorrectInfo(){
        switch previousCategory{
        case "Raad mijn droom":
            descriptionLabel.text = "Denk je dat ‘Wie ben ik’ lastig is? Probeer dan eens ‘Wat droom ik?’, voor wie van een echte uitdagingen houdt!"
            photoImage.image = UIImage(named: "Dreamguess")
            
        case "Wat is mijn karakter":
            descriptionLabel.text = " Vraag iemand om 5 karaktereigenschappen voor jou uit te kiezen. Kijk ook gerust of dat overeenkomt met wat je zelf zou invullen!"
            photoImage.image = UIImage(named: "Kwaliteiten guess")
            
        case "Quick quiz":
            descriptionLabel.text = "Je hebt 20 seconden de tijd om zoveel mogelijk vragen te beantwoorden. Tik tak tik tak, tempo."
            photoImage.image = UIImage(named: "QuickQuiz")
            
        case "Kwaliteiten quiz":
            descriptionLabel.text = "Check met deze quiz of je partner-in-crime dezelfde kwaliteiten in jou ziet als dat je dat zelf doet."
            photoImage.image = UIImage(named: "KwaliteitenQuiz")
            
        case"Foto challenge" : descriptionLabel.text = "Maak een foto die jouw droom omschrijft. Je mag items gebruiken, mensen, omgevingen, wees creatief!. Vraag eens aan anderen of ze je droom erin herkennen."
        photoImage.image = UIImage(named: "FotoChallenge")
        saveButton.tintColor = UIColor.gray
            
        case "Welja, geen nee" :
            descriptionLabel.text = "NEEgativiteit staat tussen jou en je droom in. Hoe los je dit op? Door gewoon lekker ja te zeggen, word je blij van. Bonus: Het brengt je droom een beetje (of heel veel) dichterbij. Wil je toch?"
            photoImage.image = UIImage(named: "No no")
            
        case "Ik heb een droom en ik neem mee":
            descriptionLabel.text = "Ik ga op reis en ik neem mee, maar dan met dromen! Wat heb jij nodig om jouw droom te kunnen realiseren? "
            photoImage.image = UIImage(named: "Ik heb een droom")
            startButton.isEnabled = false
            startButton.isHidden = true
            
        case "Dilemma's":
            descriptionLabel.text = "Heb je moeite met keuzes maken? Dan heb je deze dilemma’s nog niet gelezen. Oefen hier eens mee, dan worden je eigen dilemma’s makkelijker op te lossen!"
            photoImage.image = UIImage(named: "Dilemma")
            
        case "Raad de tekening":
            descriptionLabel.text = "Teken een element dat betrekking heeft op jouw droom. Laat tijdens het tekenen je vrienden raden wat het wordt!"
            photoImage.image = UIImage(named: "Draw something")
            
            default: break
        }
    }
    
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "OneToOne" {
            let viewController = segue.destination as! oneButtonViewController
            viewController.previousDifficulty = previousDifficulty
            viewController.previousCategory = previousCategory
        }
        if segue.identifier == "OneToDraw" {
            let viewController = segue.destination as! drawingViewController
            viewController.previousDifficulty = previousDifficulty
            viewController.previousCategory = previousCategory

        }
        if segue.identifier == "OneToMultiple" {
            let viewController = segue.destination as! MulipleAnswersViewController
            viewController.previousDifficulty = previousDifficulty
            viewController.previousCategory = previousCategory

        }
        if segue.identifier == "OneToTableView" {
            let viewController = segue.destination as! TableViewController
            viewController.previousDifficulty = previousDifficulty
            viewController.previousCategory = previousCategory
        }
        if segue.identifier == "OneToQuiz" {
            let viewController = segue.destination as! QuizViewController
            viewController.previousDifficulty = previousDifficulty
            viewController.previousCategory = previousCategory

        }
    }




}
