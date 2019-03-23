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
    
    var areAllCellsSelected = false;
    var selectedAllergies : [String] = []
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        for i in 0 ..< tableView.visibleCells.count{
            
            if tableView.cellForRow(at: [0,i])?.accessoryType == UITableViewCellAccessoryType.checkmark{
                
                selectedAllergies.append( (tableView.cellForRow(at: [0,i])?.textLabel?.text)!)
            }
        }
        
        if let destination = segue.destination as? allergyDisplayViewController
        {
            destination.allergyselected = selectedAllergies
        }
        
        if let destination = segue.destination as? PersonalInfoViewController{
            destination.allergies = selectedAllergies
        }
    }
    
    @IBAction func selectAllAllergies(_ sender: Any) {

        if (areAllCellsSelected == false){
            for i in 0 ..< tableView.visibleCells.count{
                tableView.cellForRow(at: [0,i])?.accessoryType = UITableViewCellAccessoryType.checkmark
                areAllCellsSelected = true
                
                self.selectionButton.title = "Deselect All"
            }
        }
            
        else {
            for i in 0 ..< tableView.visibleCells.count{
                tableView.cellForRow(at: [0,i])?.accessoryType = UITableViewCellAccessoryType.none
                areAllCellsSelected = false
                
                self.selectionButton.title = "Select All"
            }
        }
    }
    
    func areCellsSelected() -> Bool {
        for i in 0 ..< tableView.visibleCells.count{
            if tableView.cellForRow(at: [0,i])?.accessoryType == UITableViewCellAccessoryType.checkmark{
                return true
            }
        }
        return false
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
        
        if tableView.cellForRow(at: indexPath)?.accessoryType != UITableViewCellAccessoryType.checkmark{
            
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.checkmark
            areAllCellsSelected = areCellsSelected()
            
            if ( areAllCellsSelected == true){
                
                self.selectionButton.title = "Deselect All"
            }
        }
            
        else {
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.none
            
            self.selectionButton.title = "Select All"
            areAllCellsSelected = false
        }
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
            print(tableViewData[indexPath.row])
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
    
    
    
   
}

