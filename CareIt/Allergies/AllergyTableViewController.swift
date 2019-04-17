//
//  TableViewController.swift
//  Allergy
//
//  Created by Prince Geutler (student LM) on 2/28/19.
//  Copyright © 2019 Prince Geutler. All rights reserved.
//

import UIKit

class AllergyTableViewController: UITableViewController, UISearchResultsUpdating {
    
    var tableViewData = [String]()
    var sun = [String]()
    var filteredTableData = [String]()
    var resultSearchController = UISearchController()
    
    
    @IBOutlet weak var selectionButton: UIBarButtonItem!
    
    
    
    
    var selectedAllergies : [String] = []
    let defaults = UserDefaults.standard
    var selectedAllergiesIndex : [Int] = []
    var allAllergySection = Bool()
    
    
    func previouslyselected(){
        print("boi")
        if allAllergySection == false{
            let savedArrayIndexes = defaults.object(forKey: "SavedAllergiesIndex") as? [Int] ?? [Int]()
            
            for i in savedArrayIndexes{
                
                tableView.cellForRow(at: [0,i])?.accessoryType = UITableViewCellAccessoryType.checkmark
            }
        }
        else{
            let savedArrayIndexes = defaults.object(forKey: "SavedAllAllergiesIndex") as? [Int] ?? [Int]()
            
            for i in savedArrayIndexes{
                
                
                tableView.cellForRow(at: [0,i])?.accessoryType = UITableViewCellAccessoryType.checkmark
            }
        }
    }
    
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        for i in 0 ..< tableView.numberOfRows(inSection: 0){
            
            if tableView.cellForRow(at: [0,i])?.accessoryType == UITableViewCellAccessoryType.checkmark{
                selectedAllergies.append( (tableView.cellForRow(at: [0,i])?.textLabel?.text)!)
                selectedAllergiesIndex.append(i)
            }
            if allAllergySection == false{
                defaults.set(selectedAllergiesIndex, forKey: "SavedAllergiesIndex")
            }
            else{
                defaults.set(selectedAllergiesIndex, forKey: "SavedAllAllergiesIndex")
                
                
            }
        }
        if allAllergySection == true{
            
            var x = PersonalInfoViewController()
            
            x.defaults.removeObject(forKey: "addAllergies")
            
            x.defaults.set(tableViewData, forKey: "addAllergies")
           
        }
        
        
        //this adds the user's selected allergies to the the "allergies" variable in personal info view controller
        //while testing for duplicates
        if let destination = segue.destination as? PersonalInfoViewController{
            for allergy in selectedAllergies{
                if !destination.allergies.contains(allergy){
                    destination.allergies.append(allergy)
                    
                }
            }
            
        }
        
    }
    
    @IBAction func selectAllAllergies(_ sender: Any) {
        
        
        if (areCellsSelected() == false){
            
            for i in 0 ..< tableView.numberOfRows(inSection: 0){
                
                tableView.cellForRow(at: [0,i])?.accessoryType = UITableViewCellAccessoryType.checkmark
                
                
            }
            
        }
            
        else {
            for i in 0 ..< tableView.numberOfRows(inSection: 0){
                
                
                tableView.cellForRow(at: [0,i])?.accessoryType = UITableViewCellAccessoryType.none
                
            }
    
        }
        
        areCellsSelected()
    }
    
    func areCellsSelected() -> Bool {
        for i in 0 ..< tableView.numberOfRows(inSection: 0){
            
            if tableView.cellForRow(at: [0,i])?.accessoryType == UITableViewCellAccessoryType.checkmark{
                
                self.selectionButton.title = "Deselect All"
                return true
                
            }
        }
        self.selectionButton.title = "Select All"
        return false
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView.cellForRow(at: indexPath)?.accessoryType != UITableViewCellAccessoryType.checkmark{
            
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.checkmark
            
            
            
            
            
            
        }
            
        else {
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.none
            
            
            
        }
        
        areCellsSelected()
    }
    
    override func viewDidLoad() {
        
        
        
        super.viewDidLoad()
        
        self.title = "Allergies"
        resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()
            
            tableView.tableHeaderView = controller.searchBar
            
            
            
            return controller
        })()
        
        // Reload the table
        tableView.reloadData()
        
        previouslyselected()
        
        areCellsSelected()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // 1
        // return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 2
        // return the number of rows
        if  (resultSearchController.isActive) {
            return filteredTableData.count
        } else {
            return tableViewData.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 3
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        if (resultSearchController.isActive) {
            cell.textLabel?.text = filteredTableData[indexPath.row]
            
            return cell
        }
        else {
            cell.textLabel?.text = tableViewData[indexPath.row]
            
            return cell
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        filteredTableData.removeAll(keepingCapacity: false)
        
        let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchController.searchBar.text!)
        let array = (tableViewData as NSArray).filtered(using: searchPredicate)
        filteredTableData = array as! [String]
        
        
        
        
        self.tableView.reloadData()
        
        
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if allAllergySection == true{
            self.tableViewData.remove(at: indexPath.row)
            print(indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
}

