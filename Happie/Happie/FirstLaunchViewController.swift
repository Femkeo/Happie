//
//  FirstLaunchViewController.swift
//  Happie
//
//  Created by G.F Offringa on 29-05-17.
//  Copyright © 2017 femkeo. All rights reserved.
//

protocol ContainerDelegateProtocol{
    func close()
}

import UIKit

class FirstLaunchViewController: UIViewController {

    //all the outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageLabel: UIImageView!
    @IBOutlet weak var informationTextView: UITextView!
    @IBOutlet weak var tutorialPageControl: UIPageControl!
    @IBOutlet weak var launchButton: UIButton!
    
    //all the variables
    var number = 0
    var textArray = ["First", "Second", "Third"]
    var pageState = "First"
    var delegate:ContainerDelegateProtocol?
    
    
    override func viewWillAppear(_ animated: Bool) {
        //if the user reaches this page hide the navigationbutton. It is set back when this view container is hidden.
        if UserDefaults.standard.bool(forKey: "launchedBefore") == true {
        }else{
            self.navigationController?.setNavigationBarHidden(true, animated: true)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //fill in the right states
        checkingStates()
        
        //Creating the swiping option
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector((self.respond)))
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector((self.respond)))
        
        swipeRight.direction = .right
        swipeLeft.direction = .left
        
        view.addGestureRecognizer(swipeRight)
        view.addGestureRecognizer(swipeLeft)
        //end

    }
    
    
    

    //Creating the swiping function
    func respond(gesture: UIGestureRecognizer){
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction{
            case UISwipeGestureRecognizerDirection.right:
                if number > 0 {
                    arrayMaker(state: false)
                    pageState = textArray[number]
                    checkingStates()
                }
            case UISwipeGestureRecognizerDirection.left:
                if number < 2 {
                    arrayMaker(state: true)
                    pageState = textArray[number]
                    checkingStates()
                }
            default:
                break
            }
        }
    }//end swipingFunction
    
    //this adds to number when swiping
    func arrayMaker(state: Bool){
        if state == true{
            number = number + 1
        } else{
            number = number - 1
        }
    }//end
    
    
    //this fills the data that matches the current pageState
    func checkingStates(){
        if pageState == "First"{
            tutorialPageControl.currentPage = 0
            imageLabel.image = UIImage(named: "flagScene")
            titleLabel.text = "WELKOM IN H'APPIE"
            informationTextView.text = "Je hebt zojuist de eerste stap richting de realisatie van je droom gezet, gefeliciteerd!"

            launchButton.isHidden = true
        }
        else if pageState == "Second"{
            tutorialPageControl.currentPage = 1
            imageLabel.image = UIImage(named: "airBalloonScene")
            titleLabel.text = "DE REIS BEGINT HIER"
            informationTextView.text = "Je gaat spelletjes spelen en challenges uitvoeren die jou gaan helpen met de reis naar jouw droom"
            launchButton.isHidden = true
        }
        else if pageState == "Third"{
            tutorialPageControl.currentPage = 2
            imageLabel.image = UIImage(named: "superMan")
            titleLabel.text = "HOE SPEEL JE H'APPIE?"
            informationTextView.text = "Het enige wat je nu nog moet doen is je allerleukste vriend(in) opzoeken en gewoon lekker beginnen waar je zelf wilt."
            
            //everything about the button
            launchButton.isHidden = false
            launchButton.setTitle("Ik snap het!", for: .normal)
            launchButton.layer.cornerRadius = 20.0
            launchButton.layer.borderWidth = 1.5
            launchButton.layer.borderColor = UIColor.black.cgColor
            //end
        }
    }//end
    
    //this activates the close function on the original viewcontroller page.
    @IBAction func launchButtonAction(_ sender: Any) {
        delegate?.close()
    }



}
