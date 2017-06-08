//
//  EditingViewController.swift
//  Happie
//
//  Created by G.F Offringa on 29-05-17.
//  Copyright © 2017 femkeo. All rights reserved.
//

import UIKit

class EditingViewController: UIViewController {

    
    @IBOutlet weak var dreamTextField: UITextView!
    
    @IBOutlet weak var hairImage: UIImageView!
    @IBOutlet weak var skinImage: UIImageView!
    @IBOutlet weak var clothesImage: UIImageView!
    
    @IBOutlet weak var hairRightButtonOutlet: UIButton!
    @IBOutlet weak var hairLeftButtonOutlet: UIButton!
    
    @IBOutlet weak var clothesRightButtonOutlet: UIButton!
    @IBOutlet weak var clothesLeftButtonOutlet: UIButton!
    
    
    @IBOutlet weak var skinRightButtonOutlet: UIButton!
    @IBOutlet weak var skinLeftButtonOutlet: UIButton!
    
    
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
    
    var defaultAvatar = [
        "hair" : "Hair1",
        "skin" : "Skin1",
        "clothes" : "Clothes1",
        "dream" : "Vul hier je droom in"
    ]
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        if hair.isEmpty == true{
            UserDefaults.standard.set(defaultAvatar, forKey: "SettingsDict")
            hair = UserDefaults.standard.dictionary(forKey: "SettingsDict")?["hair"] as? String ?? String()
            skin = UserDefaults.standard.dictionary(forKey: "SettingsDict")?["skin"] as? String ?? String()
            clothes = UserDefaults.standard.dictionary(forKey: "SettingsDict")?["clothes"] as? String ?? String()
            dream = UserDefaults.standard.dictionary(forKey: "SettingsDict")?["dream"] as? String ?? String()
        }
        
        
        gettingRightImage(hair: hair, skin: skin, clothes: clothes)
        
        skinImage.image = UIImage(named: skinArray[skinNumber])
        hairImage.image = UIImage(named: hairArray[hairNumber])
        clothesImage.image = UIImage(named: clothesArray[clothesNumber])
        dreamTextField.text = dream
        
        checkingButtonReach()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    @IBAction func saveButtonAction(_ sender: Any) {
        defaultAvatar = [
            "hair" : hairArray[hairNumber],
            "skin" : skinArray[skinNumber],
            "clothes" : clothesArray[clothesNumber],
            "dream" : dreamTextField.text!
        ]
        UserDefaults.standard.set(defaultAvatar, forKey: "SettingsDict")
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func cancelButtonAction(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func hairButtonAction(_ sender: UIButton) {
        if sender == hairLeftButtonOutlet{
            
            if hairNumber > 0{
                hairNumber -= 1
                hairImage.image = UIImage(named: hairArray[hairNumber])
            }
        }else if sender == hairRightButtonOutlet{
            if hairNumber < hairArray.count - 1{
                hairNumber += 1
                hairImage.image = UIImage(named: hairArray[hairNumber])
            }
        }
        checkingButtonReach()
    }
    
    @IBAction func clothesButtonAction(_ sender: UIButton) {
        if sender == clothesLeftButtonOutlet{
            
            if clothesNumber > 0{
                clothesNumber -= 1
                clothesImage.image = UIImage(named: clothesArray[clothesNumber])
            }
        }else if sender == clothesRightButtonOutlet{
            if clothesNumber < clothesArray.count - 1{
                clothesNumber += 1
                clothesImage.image = UIImage(named: clothesArray[clothesNumber])
            }
        }
        checkingButtonReach()
    }
    
    
    
    
    
    @IBAction func skinButtonAction(_ sender: UIButton) {
        if sender == skinLeftButtonOutlet{
            if skinNumber > 0 {
                skinNumber -= 1
                skinImage.image = UIImage(named: skinArray[skinNumber])
            }
        }else if sender == skinRightButtonOutlet{
            if skinNumber < skinArray.count - 1{
                skinNumber += 1
                skinImage.image = UIImage(named: skinArray[skinNumber])
            }
        }
        checkingButtonReach()
    }
    
    
    
    
    func checkingButtonReach(){
        if hairNumber == hairArray.count - 1{
            hairRightButtonOutlet.isHidden = true
        }else if hairNumber == 0{
            hairLeftButtonOutlet.isHidden = true
        }else{
            hairLeftButtonOutlet.isHidden = false
            hairRightButtonOutlet.isHidden = false
        }
        
        if skinNumber == skinArray.count - 1{
            skinRightButtonOutlet.isHidden = true
        }else if skinNumber == 0{
            skinLeftButtonOutlet.isHidden = true
        }else{
            skinRightButtonOutlet.isHidden = false
            skinLeftButtonOutlet.isHidden = false
        }
        
        if clothesNumber == clothesArray.count - 1{
            clothesRightButtonOutlet.isHidden = true
        }else if clothesNumber == 0{
            clothesLeftButtonOutlet.isHidden = true
        }else{
            clothesRightButtonOutlet.isHidden = false
            clothesLeftButtonOutlet.isHidden = false
        }
        
    }
    
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
