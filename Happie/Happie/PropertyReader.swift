//
//  PropertyReader.swift
//  DreamPrototypeTwo
//
//  Created by G.F Offringa on 02-05-17.
//  Copyright © 2017 femkeo. All rights reserved.
//

import Foundation

class PropertyReader{
    //in case the struct is needed
    
    //in case the Plist is needed
    var data = [String]()
    var dictData = [String:[String]]()
    
    func readPropertyLists(startedFromSection: String){
        var sectionStart = ""
        switch startedFromSection {
        case "Raad mijn droom": sectionStart = "Dreams"
        case "Quick quiz": sectionStart = "QuickQuestions"
        case "Wat is mijn karakter": sectionStart = "Characteristics"
        case "Kwaliteiten quiz": sectionStart = "QuestionsListed"
        case "Dilemma's": sectionStart = "Dilemmas"
            
        default: sectionStart = ""
        }
        
        var format = PropertyListSerialization.PropertyListFormat.xml
        var plistData:[String:AnyObject] = [:]
        let plistPath:String? = Bundle.main.path(forResource: "QuizLists", ofType: "plist")
        let plistXML = FileManager.default.contents(atPath: plistPath!)!
        do{
            plistData = try PropertyListSerialization.propertyList(from: plistXML,
                                                                   options: .mutableContainersAndLeaves,
                                                                   format: &format)
                as! [String:AnyObject]
        }
        catch{
            print("Error reading plist: \(error), format: \(format)")
        }
        if sectionStart == "Dilemmas"{
            dictData = plistData[sectionStart] as! [String : [String]]
        }else{
            data = plistData[sectionStart] as! [String]
        }
        
        
        
        
    }
    
    var pListResult: [String]{
        get{
            return data
        }
    }
    
    var pListDictResult: [String:[String]]{
        get{
            return dictData
        }
    }
    
}
