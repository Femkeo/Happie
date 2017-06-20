//
//  drawingViewController.swift
//  Happie
//
//  Created by G.F Offringa on 06-06-17.
//  Copyright © 2017 femkeo. All rights reserved.
//

import UIKit

class drawingViewController: UIViewController {

    //all the outlets
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var undoDrawingOutlet: UIBarButtonItem!
    @IBOutlet weak var saveImageOutlet: UIBarButtonItem!
    @IBOutlet weak var backButtonOutlet: UIBarButtonItem!
    
    
    //all the variables for drawing
    var lastPoint:CGPoint!
    var isSwiping:Bool!
    var red: CGFloat = 0.0
    var green: CGFloat = 0/0
    var blue: CGFloat = 0.0
    
    //all the variables for datasaving and loading
    var gameFromPrevious = ""
    var difficultyFromPrevious = ""
    var nextDifficulty = ""
    var difficultyArray = ["easy", "medium", "hard"]
    var gameCategory = ""
    
    var gameData = UserDefaults.standard.dictionary(forKey: "Games") as! [String : [String : [String : [String : Any]]]]
    var userData = UserDefaults.standard.dictionary(forKey: "SettingsDict") ?? Dictionary()

    
    
    override func viewWillAppear(_ animated: Bool) {
        checkingDifficulties()
        checkingGameCategory(game: gameFromPrevious)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    //the image that has been drawn can be saved in photos by pressing this button
    @IBAction func saveImageAction(_ sender: Any) {
        if self.mainImageView.image == nil{
            return
        }
        UIImageWriteToSavedPhotosAlbum(self.mainImageView.image!,self, #selector(self.imageAlert(_:withPotentialError:contextInfo:)), nil)
    }
    
    //this cleans the image if button is pressed
    @IBAction func undoDrawingAction(_ sender: Any) {
        self.mainImageView.image = nil

    }
    
    //this saves the data and starts an unwind segue
    @IBAction func doneButtonAction(_ sender: Any) {
        savingAndGoingBack()
    }
    
    
    //when the button of a colour is pressed, change colour. There is a name hidden on the button which provides the colourtitle.
    @IBAction func changeColourAction(_ sender: UIButton) {
        let colourTitle = sender.currentTitle!
        
        switch colourTitle{
        case "white" : red = 255; green = 255; blue = 255;
        case "black" : red = 0; green = 0; blue = 0;
        case "brown" : red = 0.6; green = 0.4; blue = 0;
        case "blue" : red = 0; green = 0; blue = 255;
        case "green" : red = 0; green = 255; blue = 0;
        case "yellow" : red = 255; green = 255; blue = 0;
        case "orange" : red = 255; green = 0.5; blue = 0;
        case "red" : red = 255; green = 0; blue = 0;
            
        default : red = 1; blue = 1; green = 1
            
        }
    }
    
    //these monitor the movements of the user
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        isSwiping = false
        if let touch = touches.first{
            lastPoint = touch.location(in: mainImageView)
        }
    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>,
                               with event: UIEvent?){
        isSwiping = true
        if let touch = touches.first{
            backButtonOutlet.title = "Klaar!"
            let currentPoint = touch.location(in: mainImageView)
            UIGraphicsBeginImageContext(self.mainImageView.frame.size)
            self.mainImageView.image?.draw(in: CGRect(x: 0, y: 0, width: self.mainImageView.frame.size.width, height: self.mainImageView.frame.size.height))
            UIGraphicsGetCurrentContext()?.move(to: CGPoint(x: lastPoint.x, y: lastPoint.y))
            UIGraphicsGetCurrentContext()?.addLine(to: CGPoint(x: currentPoint.x, y: currentPoint.y))
            UIGraphicsGetCurrentContext()?.setLineCap(CGLineCap.round)
            UIGraphicsGetCurrentContext()?.setLineWidth(9.0)
            UIGraphicsGetCurrentContext()?.setStrokeColor(red: red, green: green, blue: blue, alpha: 1.0)
            UIGraphicsGetCurrentContext()?.strokePath()
            self.mainImageView.image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            lastPoint = currentPoint
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>,
                               with event: UIEvent?){
        if(!isSwiping) {
            // This is a single touch, draw a point
            UIGraphicsBeginImageContext(self.mainImageView.frame.size)
            self.mainImageView.image?.draw(in: CGRect(x: 0, y: 0, width: self.mainImageView.frame.size.width, height: self.mainImageView.frame.size.height))
            UIGraphicsGetCurrentContext()?.setLineCap(CGLineCap.round)
            UIGraphicsGetCurrentContext()?.setLineWidth(9.0)
            UIGraphicsGetCurrentContext()?.setStrokeColor(red: red, green: green, blue: blue, alpha: 1.0)
            UIGraphicsGetCurrentContext()?.move(to: CGPoint(x: lastPoint.x, y: lastPoint.y))
            UIGraphicsGetCurrentContext()?.addLine(to: CGPoint(x: lastPoint.x, y: lastPoint.y))
            UIGraphicsGetCurrentContext()?.strokePath()
            self.mainImageView.image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
        }
    }
    
    
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
    
    func checkingDifficulties(){
        let indexOfDifficulty = difficultyArray.index(of: difficultyFromPrevious)
        if indexOfDifficulty == 2{
            nextDifficulty = difficultyFromPrevious
        }else{
            nextDifficulty = difficultyArray[indexOfDifficulty! + 1]
        }
    }
    
    
    
    func savingAndGoingBack(){
        self.performSegue(withIdentifier: "BackToStartFromDraw", sender: self)
        if backButtonOutlet.title == "Klaar!"{
            updateScore()
            var newCounterValue = 0
            let counter = gameData["Categories"]![gameCategory]![gameFromPrevious]!["counter"]! as! Int
            newCounterValue = counter + 1
            
            let dataToUpdate = GameData()
            dataToUpdate.creatingGames()
            var newData = dataToUpdate.result
            
            newData["Categories"]![gameCategory]![gameFromPrevious]![nextDifficulty]! = true
            
            newData["Categories"]![gameCategory]![gameFromPrevious]!["counter"] = newCounterValue
            
            UserDefaults.standard.set(newData, forKey: "Games")

        }
    }
    
    
    
    
    func updateScore(){
        var newScoreValue: Float = 0.0
        let score = userData["userScore"] as! Float
        
        switch difficultyFromPrevious{
        case "easy" : newScoreValue = 50
        case "medium" : newScoreValue = 100
        case "hard" : newScoreValue = 150
        default: newScoreValue = 50
        }
        newScoreValue += score
        
        let dataToUpdate = UserData()
        dataToUpdate.creatingUserData()
        var newData = dataToUpdate.result
        
        newData["userScore"] = newScoreValue
        
        UserDefaults.standard.set(newData, forKey: "SettingsDict")
        
    }

    
    
    //this gives an alert when the image is saved succesfully
    func imageAlert(_ image: UIImage, withPotentialError error: NSErrorPointer, contextInfo: UnsafeRawPointer) {
        let alert =  UIAlertController(title: nil, message: "Je foto is succesvol opgeslagen!", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(OKAction)
        
        self.present(alert, animated: true)
    }



}
