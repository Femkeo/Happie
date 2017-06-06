//
//  QuizViewController.swift
//  Happie
//
//  Created by G.F Offringa on 06-06-17.
//  Copyright © 2017 femkeo. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {

    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet var buttons: [UIButton]!
    @IBOutlet weak var countingLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    
    var previousCategory = ""
    var previousDifficulty = ""
    var Reader = PropertyReader()
    var QuestionList = [String]()
    
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        for i in 0..<buttons.count {
            buttons[i].layer.cornerRadius = 7.0
            buttons[i].layer.borderWidth = 2.0
            buttons[i].layer.borderColor = UIColor.black.cgColor
        }
        
        gettingPreviousInfo(startedFromSection: previousCategory)
        showQualityQuestions()
    }
    
    func updateTimer() {
        seconds -= 1
        timerLabel.text = "\(seconds)"
        
        if seconds == 0{
            timer.invalidate()
            timesUpFunction(inTime: false)
        }
    }
    
    @IBAction func answerAction(_ sender: UIButton) {
        buttonSender = sender
        gettingCorrectButtonInfo()
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
    
    
   
    
    func showQualityQuestions(){
        if answersFilledIn == true{
            if Questions.count > 0 {
                questionNumber = Int(arc4random_uniform(UInt32(Questions.count)))
                questionLabel.text = Questions[questionNumber].question
                CorrectAnswer = Questions[questionNumber].answer
                
                for i in 0..<buttons.count {
                    buttons[i].setTitle(Questions[questionNumber].answers[i], for: .normal)
                }
                Questions.remove(at: questionNumber)
                
            }else{
                NSLog("super done")
                disabelingButtons()
                questionLabel.text = "Gefeliciteerd! Je hebt \(Reader.pListResult.count - numberOfWrongAnswers) antwoorden in 1 keer goed"
            }
        }else{
            if Reader.pListResult.count > Questions.count {
                questionNumber = Int(arc4random_uniform(UInt32(Reader.pListResult.count)))
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
    
    func disabelingButtons(){
        for i in 0..<buttons.count {
            buttons[i].isHidden = true
            buttons[i].isEnabled = false
        }
    }
    
    func gettingPreviousInfo(startedFromSection: String){
        Reader.readPropertyLists(startedFromSection: startedFromSection)
        
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
            
            
            
        default: break
        }
    }
    
    
    
    func gettingCorrectButtonInfo(){
        switch previousCategory{
            
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
