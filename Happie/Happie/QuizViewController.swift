//
//  QuizViewController.swift
//  Happie
//
//  Created by G.F Offringa on 06-06-17.
//  Copyright © 2017 femkeo. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {

    //all the outlets
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet var buttons: [UIButton]!
    @IBOutlet weak var countingLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var timerImage: UIImageView!
    
    //all the variables
    var difficultyArray = ["easy", "medium", "hard"]
    var gameFromPrevious = ""
    var difficultyFromPrevious = ""
    var nextDifficulty = ""
    var gameCategory = ""
    var Reader = PropertyReader()
    var QuestionList = [String]()
    var gameData = UserDefaults.standard.dictionary(forKey: "Games") as! [String : [String : [String : [String : Any]]]]
    var userData = UserDefaults.standard.dictionary(forKey: "SettingsDict") ?? Dictionary()

    
    //these are the QuilitiesQuiz vars
    var questionNumber = Int()
    var buttonSender: UIButton?
    var answersFilledIn = false
    var CorrectAnswer = String()
    var numberOfWrongAnswers = 0
    var Questions = [Question]()
    var QuestionArray = [String]()
    
    //these are the quickQuestions vars
    var number = 0
    var timer = Timer()
    var seconds = 20
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        checkingDifficulties()
        checkingGameCategory(game: gameFromPrevious)
        gettingPreviousInfo(startedFromSection: gameFromPrevious)
        showQualityQuestions()
        settingDesign()

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //this sets the timer and its label for the quickquiz
    func updateTimer() {
        seconds -= 1
        timerLabel.text = "\(seconds)"
        
        if seconds == 0{
            timer.invalidate()
            timesUpFunction(inTime: false)
        }
    }
    
    
    
    
    //this checks the buttons for input and if needed loads new data
    @IBAction func answerAction(_ sender: UIButton) {
        if sender.currentTitle == "Klaar!"{
            savingAndGoingBack()
        }else{
            buttonSender = sender
            gettingCorrectButtonInfo()
        }
        
    }
    
    
    
    //This happens when the times up or you've answered all the questions
    func timesUpFunction(inTime: Bool){
        if inTime == true{
            questionLabel.text = "Heel goed! Je hebt \(number + 1) vragen beantwoord en je hebt nog \(seconds) seconden over!"
            timer.invalidate()
        }else{
            if number != 1{
                questionLabel.text = "Je hebt \(number) vragen beantwoord!"
                
            }else{
                questionLabel.text = "Je hebt 1 vraag beantwoord!"
            }
        }
        disabelingButtons()
        timerLabel.text = ""
        countingLabel.text = ""
    }
    
    
   
    //this shows the questions when the qualitiesquiz is played.
    func showQualityQuestions(){
        //if this is the second player (awnsers have been filled in) execute this
        if answersFilledIn == true{
            //check if there are questions left
            if Questions.count > 0 {
                //get a random question
                questionNumber = Int(arc4random_uniform(UInt32(Questions.count)))
                //show the question to the user
                questionLabel.text = Questions[questionNumber].question
                //register which question the other user marked as correct
                CorrectAnswer = Questions[questionNumber].answer
                
                //show the answers to the user
                for i in 0..<buttons.count {
                    buttons[i].setTitle(Questions[questionNumber].answers[i], for: .normal)
                }
                //if done, make sure the question can't appear again.
                Questions.remove(at: questionNumber)
            }else{
                //If the game is finished, make sure the buttons are set to their correct state
                disabelingButtons()
                //show the number correct answers to the user
                questionLabel.text = "Gefeliciteerd! Je hebt \(Reader.pListResult.count - numberOfWrongAnswers) antwoorden in 1 keer goed"
            }
        }else{
            //if the questions have previously been entered, load questions untill there are as much new saved questions as there are original questions.
            if Reader.pListResult.count > Questions.count {
                //get a random question
                questionNumber = Int(arc4random_uniform(UInt32(Reader.pListResult.count)))
                //if the question is original show
                if QuestionArray.contains(Reader.pListResult[questionNumber]){
                    showQualityQuestions()
                }else{
                    questionLabel.text = Reader.pListResult[questionNumber]
                }
            }else{
                NSLog("done")
                alert()
            }
        }
    }
    
    
    
    //give the buttons a job to match the desire of the game
    func disabelingButtons(){
        for _ in 0..<buttons.count {
            buttons[1].isHidden = true
            buttons[1].isEnabled = false
            buttons[0].isEnabled = true
            buttons[0].isHidden = false
            buttons[0].setTitle("Klaar!", for: .normal)
        }
    }
    
    
    
    func gettingPreviousInfo(startedFromSection: String){
        Reader.readPropertyLists(startedFromSection: startedFromSection)
        print("Hi \(startedFromSection)")
        switch startedFromSection{
            
        case "Quick quiz":
            //Reading data from Plist and setting it
            QuestionList = Reader.pListResult
            questionLabel.text = QuestionList[number]
            countingLabel.text = " "
            //starting timer
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(self.updateTimer)), userInfo: nil, repeats: true)
            timerLabel.text = "\(seconds)"
            
            
            
        case "Kwaliteiten quiz":
            QuestionList = Reader.pListResult
            questionLabel.text = Reader.pListResult[questionNumber]
            countingLabel.text = ""
            timerLabel.text = ""
            timerImage.image = UIImage(named:"Lamp")
            
            
        default: break
        }
    }
    
    
    
    func settingDesign(){
        for i in 0..<buttons.count {
            buttons[i].layer.cornerRadius = 7.0
            buttons[i].layer.borderWidth = 2.0
            buttons[i].layer.borderColor = UIColor.black.cgColor
        }
        
        questionLabel.adjustsFontSizeToFitWidth = true
        questionLabel.minimumScaleFactor = 0.2
        questionLabel.numberOfLines = 50

    }
    
    
    
    func gettingCorrectButtonInfo(){
        print("hey! \(answersFilledIn)")

        switch gameFromPrevious{
        case "Quick quiz":
            
            if number < QuestionList.count - 1 {
                number += 1
                questionLabel.text = QuestionList[number]
                countingLabel.text = "\(number)"
            }else{
                timesUpFunction(inTime: true)
            }
            
            
        case "Kwaliteiten quiz":
            if answersFilledIn == true{
                if buttonSender?.currentTitle == CorrectAnswer {
                    NSLog("Right!")
                    showQualityQuestions()
                }else{
                    NSLog("Wrong!")
                    numberOfWrongAnswers += 1
                }
            }else{
                if Questions.count == 0{
                    Questions = [Question(question: "\(questionLabel.text!)", answers: ["JA", "NEE"], answer: "\(buttonSender!.currentTitle!)")]
                    QuestionList.append("\(questionLabel.text!)")
                }else{
                    Questions.append(Question(question: "\(questionLabel.text!)", answers: ["JA", "NEE"], answer: "\(buttonSender!.currentTitle!)"))
                    QuestionArray.append("\(questionLabel.text!)")
                }
                showQualityQuestions()
                
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
        self.performSegue(withIdentifier: "BackToGames", sender: self)
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
    
    
    
    
    func alert(){
        let alert =  UIAlertController(title: nil, message: "Laat nu iemand raden welke antwoorden je hebt gegeven!", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(OKAction)
        self.present(alert, animated: true)
        //setting new info
        answersFilledIn = true
        showQualityQuestions()
        gettingCorrectButtonInfo()
    }
}
