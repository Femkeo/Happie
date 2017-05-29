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

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageLabel: UIImageView!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var tutorialPageControl: UIPageControl!
    @IBOutlet weak var launchButton: UIButton!
    
    var number = 0
    var textArray = ["First", "Second", "Third"]
    var pageState = "First"
    var delegate:ContainerDelegateProtocol?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
            textLabel.text = "First"
            launchButton.isHidden = true
        }
        else if pageState == "Second"{
            tutorialPageControl.currentPage = 1
            textLabel.text = "Second"
            launchButton.isHidden = true
        }
        else if pageState == "Third"{
            tutorialPageControl.currentPage = 2
            textLabel.text = "Third"
            launchButton.isHidden = false
        }
    }//end
    
    @IBAction func launchButtonAction(_ sender: Any) {
        UserDefaults.standard.set(true, forKey: "launchedBefore")
        delegate?.close()
    }



}
