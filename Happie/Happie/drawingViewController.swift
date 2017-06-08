//
//  drawingViewController.swift
//  Happie
//
//  Created by G.F Offringa on 06-06-17.
//  Copyright © 2017 femkeo. All rights reserved.
//

import UIKit

class drawingViewController: UIViewController {

    
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var undoDrawingOutlet: UIBarButtonItem!
    @IBOutlet weak var saveImageOutlet: UIBarButtonItem!
    
    var lastPoint:CGPoint!
    var isSwiping:Bool!
    var red: CGFloat = 0.0
    var green: CGFloat = 0/0
    var blue: CGFloat = 0.0
    
    var previousCategory = ""
    var previousDifficulty = ""
    var nextDifficulty = ""
    var difficultyArray = ["easy", "medium", "hard"]


    
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

    }
    
    @IBAction func saveImageAction(_ sender: Any) {
        if self.mainImageView.image == nil{
            return
        }
        UIImageWriteToSavedPhotosAlbum(self.mainImageView.image!,self, #selector(self.imageAlert(_:withPotentialError:contextInfo:)), nil)
    }
    
    @IBAction func undoDrawingAction(_ sender: Any) {
        self.mainImageView.image = nil

    }
    
    @IBAction func doneButtonAction(_ sender: Any) {
        self.performSegue(withIdentifier: "BackToStartFromDraw", sender: self)
        var newCounterValue = 0
        let counter = userData["Categories"]!["Droom het"]![previousCategory]!["counter"]! as! Int
        newCounterValue = counter + 1
        
        let dataToUpdate = GameData()
        dataToUpdate.creatingGames()
        var newData = dataToUpdate.result
        
        newData["Categories"]!["Droom het"]![previousCategory]![nextDifficulty]! = true
        
        newData["Categories"]!["Droom het"]![previousCategory]!["counter"] = newCounterValue
        
        UserDefaults.standard.set(newData, forKey: "Games")
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>,
                               with event: UIEvent?){
        isSwiping    = false
        if let touch = touches.first{
            lastPoint = touch.location(in: mainImageView)
        }
    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>,
                               with event: UIEvent?){
        isSwiping = true;
        if let touch = touches.first{
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
    
    func imageAlert(_ image: UIImage, withPotentialError error: NSErrorPointer, contextInfo: UnsafeRawPointer) {
        let alert =  UIAlertController(title: nil, message: "Image successfully saved to Photos library", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(OKAction)
        
        self.present(alert, animated: true)
    }



}
