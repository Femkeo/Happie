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
    
    
    var previousCategory = ""
    var previousDifficulty = ""
    var Reader = PropertyReader()
    var dreamToUse: String?
    var selectedArray = [Int]()
    var currentIndexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Reader.readPropertyLists(startedFromSection: previousCategory)
        
        if previousCategory == "Wat is mijn karakter"{
            personalityImage.image = UIImage(named: "Kwaliteiten guess")
        }else{
            personalityImage.image = UIImage(named: "Dreamguess")
        }
        
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
        return previousCategory
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath)
        let row = indexPath.row
        cell.textLabel?.text = Reader.pListResult[row]
        if previousCategory == "Wat is mijn karakter"{
            cell.selectionStyle = UITableViewCellSelectionStyle.none
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentIndexPath = indexPath
        print("Here is the indexpath row \(indexPath.row)")
        provideCorrectInfo()
        if previousCategory == "Wat is mijn karakter"{
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
        if previousCategory == "Wat is mijn karakter"{
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
        switch previousCategory{
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "WhatDoIDreamSegue" {
            let viewController = segue.destination as! WhatDoIDreamViewController
            viewController.currentDream = dreamToUse!
            viewController.previousCategory = previousCategory
            viewController.previousDifficulty = previousDifficulty
        }
    }


    

}
