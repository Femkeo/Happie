//
//  oneButtonViewController.swift
//  Happie
//
//  Created by G.F Offringa on 06-06-17.
//  Copyright © 2017 femkeo. All rights reserved.
//

import UIKit

class oneButtonViewController: UIViewController {

    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var previousCategory = ""
    var previousDifficulty = ""
    var Yes = YesSayer()
    var hasLoadedBefore = false
    var number = 0
    
    
    override func viewWillAppear(_ animated: Bool) {
        number += 1
        if number == 2{
            hasLoadedBefore = true
        }
        if hasLoadedBefore == true{
            if previousCategory != "Dilemma's"{
                if previousCategory != "(Fotochallenge: Beeld iets uit met foto's)"{
                    startButton.isHidden = true
                    startButton.isEnabled = true
                    photoImage.image = UIImage(named: "lightbulb")
                    switch previousCategory{
                    case "Wat droom ik": descriptionLabel.text = "Soms vergeet je de details en dat is helemaal niet erg! Toch is het goed om zo nu en dan stil te staan bij alle ins en outs van je droom. Je hebt zonet allemaal droom-gerelateerde vragen gesteld, doe dit ook eens bij je eigen droom. Kom maar op met al die nieuwe inzichten!"
                    case "Karakter eigenschappen kiezen": descriptionLabel.text = "Anderen kunnen je soms positiever zien dan dat jij jezelf ziet. Dat kan je ogen openen. Besef dat jij de juiste eigenschappen hebt om jouw droom uit te laten komen. Dus hup hup, je kan het!"
                    case "Snelle antwoorden!": descriptionLabel.text = "Je hebt zonet vol overtuiging een hele hoop keuzes gemaakt. Het maken van keuzes zul je in de toekomst nog vaak moeten doen, zeker als je bezig gaat met het realiseren van je droom. Gelukkig kun je jezelf hierin trainen door regelmatig knopen door te hakken. Je zult erachter komen dat je eigenlijk heel goed bent in het maken van de juiste beslissing!"
                    case "Kwaliteiten Quiz": descriptionLabel.text = "Soms zie je je eigen kwaliteiten niet super scherp. Daarom kan jouw partner-in-crime jou net even een confidence boost geven door jouw kwaliteiten te benoemen. Vraag tijdens de weg naar jouw droom eens naar feedback van de mensen om je heen. Je zult merken dat het je zal motiveren en wie wordt er nou niet blij van een paar veren in zijn reet."
                    case "DreamDrawing": descriptionLabel.text = "Door goed na te denken over hoe je jouw droom n voor een ander kunt visualisere, ga je veel beter over je droom nadenken. Daarnaast brengt het delen van je droom met anderen, je iets dichter bij het realiseren van je droom. Doe dit dus vooral!"
                    default: break
                    }
                }
            }
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
                imagePicker.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
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
        descriptionLabel.text = "Waarschijnlijk heb je al een beeld in je hoofd van hoe het zal zijn als je je droom gerealiseerd hebt. Dat is hartstikke goed! Het is nog beter als je deze visualisatie in beeld brengt, zoals je zonet hebt gedaan. Hierdoor heb je iets tastbaars om op terug te kijken als je droombeeld even niet zo helder is. "
        startButton.setTitle("Opnieuw", for: .normal)
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
