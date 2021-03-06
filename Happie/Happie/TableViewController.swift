//
//  TableViewController.swift
//  Happie
//
//  Created by G.F Offringa on 06-06-17.
//  Copyright © 2017 femkeo. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    //all the outlets
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var infoImage: UIImageView!
    @IBOutlet weak var backButtonOutlet: UIBarButtonItem!
    
    //all the variables for saving data
    var gameFromPrevious = ""
    var difficultyFromPrevious = ""
    var nextDifficulty = ""
    var difficultyArray = ["easy", "medium", "hard"]
    var gameCategory = ""
    var dreamToUse: String?
    var selectedArray = [Int]()
    var currentIndexPath: IndexPath?
    
    var gameData = UserDefaults.standard.dictionary(forKey: "Games") as! [String : [String : [String : [String : Any]]]]
    var userData = UserDefaults.standard.dictionary(forKey: "SettingsDict") ?? Dictionary()

    //this connects to the model that reads the Plist
    var Reader = PropertyReader()
    
    override func viewWillAppear(_ animated: Bool) {
        //this reads the data from the Plist that matches the current game
        Reader.readPropertyLists(startedFromSection: gameFromPrevious)
        
        checkingDifficulties()
        checkingGameCategory(game: gameFromPrevious)
        
        //this makes the lable scalable
        infoLabel.adjustsFontSizeToFitWidth = true
        infoLabel.minimumScaleFactor = 0.2
        infoLabel.numberOfLines = 50

        //give the right text depending on the game
        if gameFromPrevious == "Wat is mijn karakter"{
            infoLabel.text = "Ik vind jou:"
            infoImage.image = UIImage(named: "Persoonlijkheid")
        }else{
            infoLabel.text = "Kies een droom voor de ander zonder dat deze het ziet!"
            infoImage.image = UIImage(named: "Wat droom ik")
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    
    
    //saving when hitting button
    @IBAction func doneButtonAction(_ sender: Any) {
        savingAndGoingBack()
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    
    
    
    //filling the tableviews
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Reader.pListResult.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return gameFromPrevious
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath)
        let row = indexPath.row
        cell.textLabel?.text = Reader.pListResult[row]
        if gameFromPrevious == "Wat is mijn karakter"{
            cell.selectionStyle = UITableViewCellSelectionStyle.none
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentIndexPath = indexPath
        if gameFromPrevious == "Raad mijn droom"{
            alert()
        }
        if gameFromPrevious == "Wat is mijn karakter"{
            provideCorrectInfo()
            if selectedArray.count < 5{
                if let selectedCell:UITableViewCell = tableView.cellForRow(at: indexPath){
                    selectedCell.backgroundColor = UIColor(red:151/255.0, green:204/255.0, blue:248/255.0, alpha: 1.0)
                    selectedArray.append(indexPath.row)
                    
                }
            }
            if selectedArray.count == 5{
                backButtonOutlet.title = "Klaar!"
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if backButtonOutlet.title == "Klaar!" && selectedArray.count == 5{
            backButtonOutlet.title = "Terug"
        }
        if gameFromPrevious == "Wat is mijn karakter"{
            if let arrayIndex = selectedArray.index(of: indexPath.row){
                if let selectedCell:UITableViewCell = tableView.cellForRow(at: indexPath){
                    selectedCell.backgroundColor = UIColor(red:253/255.0, green:252/255.0, blue:248/255.0, alpha: 1.0)
                    selectedArray.remove(at: arrayIndex)
                }
            }
        }
    }
    
    
    
    
    
    func provideCorrectInfo(){
        switch gameFromPrevious{
        case "Raad mijn droom":
            let indexPath = tableView.indexPathForSelectedRow!
            let currentCell = tableView.cellForRow(at: indexPath)! as UITableViewCell
            dreamToUse = currentCell.textLabel?.text
            performSegue(withIdentifier: "WhatDoIDreamSegue", sender: self)
    
            
        case "Wat is mijn karakter":
            if let arrayIndex = selectedArray.index(of: (currentIndexPath!.row)){
                if let selectedCell:UITableViewCell = tableView.cellForRow(at: currentIndexPath!){
                    selectedCell.backgroundColor = UIColor.clear
                    selectedArray.remove(at: arrayIndex)
                }
            }
        default: break
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
        self.performSegue(withIdentifier: "BackToGamesFromTable", sender: self)
        if gameFromPrevious == "Wat is mijn karakter"{
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
    
    //this makes sure the user does something before continuing by showing an alert and only responding to ok
    func alert(){
        let alert =  UIAlertController(title: nil, message: "Doe de iPhone op de ander z'n hoofd en druk dan pas op ok!", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default){
        UIAlertAction in self.initiateSegue()
        }
        alert.addAction(OKAction)
        self.present(alert, animated: true, completion:  nil)
    }
    
    //this makes sure providecorrectinfo is called after the alert
    func initiateSegue(){
        provideCorrectInfo()
    }
    
    
    
    //depending on which game, a new ViewController can be connected
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "WhatDoIDreamSegue" {
            let viewController = segue.destination as! WhatDoIDreamViewController
            viewController.currentDream = dreamToUse!
            viewController.gameFromPrevious = gameFromPrevious
            viewController.difficultyFromPrevious = difficultyFromPrevious
        }
    }
}
