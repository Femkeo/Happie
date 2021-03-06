//
//  EditingViewController.swift
//  Happie
//
//  Created by G.F Offringa on 29-05-17.
//  Copyright © 2017 femkeo. All rights reserved.
//

import UIKit


class EditingViewController: UIViewController, UITextFieldDelegate {
    
    //all the outlets
    @IBOutlet weak var dreamTextField: UITextField!
    
    @IBOutlet weak var hairImage: UIImageView!
    @IBOutlet weak var skinImage: UIImageView!
    @IBOutlet weak var clothesImage: UIImageView!
    
    @IBOutlet weak var hairRightButtonOutlet: UIButton!
    @IBOutlet weak var hairLeftButtonOutlet: UIButton!
    
    @IBOutlet weak var clothesRightButtonOutlet: UIButton!
    @IBOutlet weak var clothesLeftButtonOutlet: UIButton!
    @IBOutlet weak var backButtonOutlet: UIBarButtonItem!
    
    @IBOutlet weak var skinRightButtonOutlet: UIButton!
    @IBOutlet weak var skinLeftButtonOutlet: UIButton!
    
    //import the UserData model
    var Data = UserData()
    
    //these groupes make sure the user can create new data for their avatar
    var skinArray = ["Skin1","Skin2","Skin3", "Skin4", "Skin5"]
    var skinNumber = 0
    var skin: String = UserDefaults.standard.dictionary(forKey: "SettingsDict")?["skin"] as? String ?? String()

    var hairArray = ["Hair1", "Hair2", "Hair3", "Hair4", "Hair5", "Hair6", "Hair7", "Hair8", "Hair9"]
    var hairNumber = 0
    var hair: String = UserDefaults.standard.dictionary(forKey: "SettingsDict")?["hair"] as? String ?? String()
    
    var clothesArray = ["Clothes1", "Clothes2", "Clothes3", "Clothes4"]
    var clothesNumber = 0
    var clothes: String = UserDefaults.standard.dictionary(forKey: "SettingsDict")?["clothes"] as? String ?? String()

    var dream: String = UserDefaults.standard.dictionary(forKey: "SettingsDict")?["dream"] as? String ?? String()
    var userScore: Float = UserDefaults.standard.dictionary(forKey: "SettingsDict")?["userScore"] as? Float ?? Float()

    
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)

        if UserDefaults.standard.bool(forKey: "launchedBefore") == false{
            UserDefaults.standard.set(true, forKey: "launchedBefore")

            //if this page is reached for the first time. Make sure the previous tutorial is no longer shown and hide the back button.
            backButtonOutlet.tintColor = UIColor.clear
            dreamTextField.text = "Vul hier je droom in"
            dreamTextField.textColor = UIColor.lightGray
        }else{
            backButtonOutlet.tintColor = UIColor(red: CGFloat(0.0), green: CGFloat(122.0 / 255.0), blue: CGFloat(1.0), alpha: CGFloat(1.0))

            dreamTextField.text = dream
        }
        
        //this checks (if their is) stored data.
        Data.creatingUserData()
        
        //if when this viewcontroller was loaded the data hasnt been loaded yet, do that now
        if hair.isEmpty == true{
            UserDefaults.standard.set(Data.result, forKey: "SettingsDict")
            hair = UserDefaults.standard.dictionary(forKey: "SettingsDict")?["hair"] as? String ?? String()
            skin = UserDefaults.standard.dictionary(forKey: "SettingsDict")?["skin"] as? String ?? String()
            clothes = UserDefaults.standard.dictionary(forKey: "SettingsDict")?["clothes"] as? String ?? String()
            dream = UserDefaults.standard.dictionary(forKey: "SettingsDict")?["dream"] as? String ?? String()
            userScore = UserDefaults.standard.dictionary(forKey: "SettingsDict")?["userScore"] as? Float ?? Float()
        }
        
        //starting the picking of characteritems, starting with the avataritems that are already chosen.
        gettingRightImage(hair: hair, skin: skin, clothes: clothes)
        //filling the images with the above colected data
        skinImage.image = UIImage(named: skinArray[skinNumber])
        hairImage.image = UIImage(named: hairArray[hairNumber])
        clothesImage.image = UIImage(named: clothesArray[clothesNumber])
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setting options for the textfield
        dreamTextField.delegate = self
        dreamTextField.text = "Begin met typen"
        dreamTextField.textColor = UIColor.lightGray
        dreamTextField.layer.cornerRadius = 8.0
        dreamTextField.clipsToBounds = true

    }
    
    
    
    
    //giving textfield orders
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.textColor == UIColor.lightGray {
            textField.text = nil
            textField.textColor = UIColor.black
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if (textField.text?.isEmpty)! {
            dreamTextField.text = "Begin met typen"
            dreamTextField.textColor = UIColor.lightGray
        }
        resignFirstResponder()
    }
        
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    
    
    //save all the selected avatar items in the userdefaults
    @IBAction func saveButtonAction(_ sender: Any) {
        var newScoreValue: Float = 25.0
        let score = userScore
        newScoreValue += score
        
        let userDataUpdate = [
            "hair" : hairArray[hairNumber],
            "skin" : skinArray[skinNumber],
            "clothes" : clothesArray[clothesNumber],
            "dream" : dreamTextField.text!,
            "userScore": newScoreValue
        ] as [String : Any]
        UserDefaults.standard.set(userDataUpdate, forKey: "SettingsDict")
        self.navigationController?.popToRootViewController(animated: true)
    }

    
    
    //cancel and do nothing
    @IBAction func cancelButtonAction(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    
    //this makes the user loop through all the hair items
    @IBAction func hairButtonAction(_ sender: UIButton) {
        if sender == hairLeftButtonOutlet{
            
            if hairNumber > 0{
                hairNumber -= 1
            }else{
                hairNumber = hairArray.count - 1
            }
        }else if sender == hairRightButtonOutlet{
            if hairNumber < hairArray.count - 1{
                hairNumber += 1
            }else{
                hairNumber = 0
            }
        }
        hairImage.image = UIImage(named: hairArray[hairNumber])
    }
    
    //this makes the user loop through all the clothing items
    @IBAction func clothesButtonAction(_ sender: UIButton) {
        if sender == clothesLeftButtonOutlet{
            
            if clothesNumber > 0{
                clothesNumber -= 1
            }else{
                clothesNumber = clothesArray.count - 1
            }
        }else if sender == clothesRightButtonOutlet{
            if clothesNumber < clothesArray.count - 1{
                clothesNumber += 1
            }else{
                clothesNumber = 0
            }
        }
        clothesImage.image = UIImage(named: clothesArray[clothesNumber])

    }
    
    //this makes the user loop through all the skin items
    @IBAction func skinButtonAction(_ sender: UIButton) {
        if sender == skinLeftButtonOutlet{
            if skinNumber > 0 {
                skinNumber -= 1
            }else{
                skinNumber = skinArray.count - 1
            }
        }else if sender == skinRightButtonOutlet{
            if skinNumber < skinArray.count - 1{
                skinNumber += 1
            }else{
                skinNumber = 0
            }
        }
        skinImage.image = UIImage(named: skinArray[skinNumber])

    }
    
    

    //this makes the arrays start at the items of the avatar that is already saved.
    func gettingRightImage(hair: String, skin: String, clothes: String){
        if skinArray.contains(skin){
            skinNumber = skinArray.index(of: skin)!
        }else{
            skinNumber = 0
        }
        if hairArray.contains(hair){
            hairNumber = hairArray.index(of: hair)!
        }else{
            hairNumber = 0
        }
        if clothesArray.contains(clothes){
            clothesNumber = clothesArray.index(of: clothes)!
        }else{
            clothesNumber = 0
        }
        
        hairImage.image = UIImage(named: hairArray[hairNumber])
        skinImage.image = UIImage(named: skinArray[skinNumber])
        clothesImage.image = UIImage(named: clothesArray[clothesNumber])
    }

    
}
