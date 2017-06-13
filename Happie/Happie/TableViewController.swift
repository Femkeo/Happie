//
//  TableViewController.swift
//  Happie
//
//  Created by G.F Offringa on 06-06-17.
//  Copyright © 2017 femkeo. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    
    
    @IBOutlet weak var personalityImage: UIImageView!
    
    
    var gameFromPrevious = ""
    var difficultyFromPrevious = ""
    var nextDifficulty = ""
    var difficultyArray = ["easy", "medium", "hard"]
    var gameCategory = ""
    
    var Reader = PropertyReader()
    var dreamToUse: String?
    var selectedArray = [Int]()
    var currentIndexPath: IndexPath?
    
    var gameData = UserDefaults.standard.dictionary(forKey: "Games") as! [String : [String : [String : [String : Any]]]]
    var userData = UserDefaults.standard.dictionary(forKey: "SettingsDict") ?? Dictionary()

    
    
    
    override func viewWillAppear(_ animated: Bool) {
        checkingDifficulties()
        checkingGameCategory(game: gameFromPrevious)
        Reader.readPropertyLists(startedFromSection: gameFromPrevious)

        if gameFromPrevious == "Wat is mijn karakter"{
            personalityImage.image = UIImage(named: "Kwaliteiten guess")
        }else{
            personalityImage.image = UIImage(named: "Dreamguess")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func doneButtonAction(_ sender: Any) {
        savingAndGoingBack()
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
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
        provideCorrectInfo()
        if gameFromPrevious == "Wat is mijn karakter"{
            if selectedArray.count < 5{
                if let selectedCell:UITableViewCell = tableView.cellForRow(at: indexPath){
                    selectedCell.backgroundColor = UIColor(red:151/255.0, green:204/255.0, blue:248/255.0, alpha: 1.0)
                    print("You selected cell #\(indexPath.row)!")
                    selectedArray.append(indexPath.row)
                    print(selectedArray)
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if gameFromPrevious == "Wat is mijn karakter"{
            if let arrayIndex = selectedArray.index(of: indexPath.row){
                if let selectedCell:UITableViewCell = tableView.cellForRow(at: indexPath){
                    selectedCell.backgroundColor = UIColor(red:253/255.0, green:252/255.0, blue:248/255.0, alpha: 1.0)
                    selectedArray.remove(at: arrayIndex)
                    print("After appending \(selectedArray)")
                }
            }
        }
    }
    
    
    func provideCorrectInfo(){
        switch gameFromPrevious{
        case "Raad mijn droom":
            //data = self.tableData[indexPath.row]
            let indexPath = tableView.indexPathForSelectedRow!
            let currentCell = tableView.cellForRow(at: indexPath)! as UITableViewCell
            dreamToUse = currentCell.textLabel?.text
            performSegue(withIdentifier: "WhatDoIDreamSegue", sender: self)
    
            
        case "Wat is mijn karakter":
            if let arrayIndex = selectedArray.index(of: (currentIndexPath!.row)){
                if let selectedCell:UITableViewCell = tableView.cellForRow(at: currentIndexPath!){
                    selectedCell.backgroundColor = UIColor.clear
                    selectedArray.remove(at: arrayIndex)
                    print("After removal \(selectedArray)")
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
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "WhatDoIDreamSegue" {
            let viewController = segue.destination as! WhatDoIDreamViewController
            viewController.currentDream = dreamToUse!
            viewController.gameFromPrevious = gameFromPrevious
            viewController.difficultyFromPrevious = difficultyFromPrevious
        }
    }


    

}
