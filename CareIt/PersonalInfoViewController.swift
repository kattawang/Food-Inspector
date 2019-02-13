//
//  PersonalInfoViewController.swift
//  CareIt
//
//  Created by Annie Liang (student LM) on 1/29/19.
//  Copyright © 2019 Jason Kozarsky (student LM). All rights reserved.
//

import Foundation
import FirebaseDatabase
import UIKit

class PersonalInfoViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{
    
    @IBOutlet weak var sex: UIPickerView!
    @IBOutlet weak var birthday: UIDatePicker!
    @IBOutlet weak var weight: UIPickerView!
    @IBOutlet weak var height: UIPickerView!
    @IBOutlet weak var activityLevel: UIPickerView!
    @IBAction func doneButtonTouchedUp(_ sender: UIButton) {
        ref = Database.database().reference()
        //UPLOAD TO DATABSE HERE
       // ref?.child("Sex").childByAutoId().setValue(sexChoice)
        
        self.performSegue(withIdentifier: "toCalorieScreen", sender: self)
    }
    
    var ref: DatabaseReference?
    var sexOptions = ["Male", "Female", "Other"]
    var weightOptions = (0...1400).map{$0}
    var heightOptions = (0...100).map{$0}
    var activityLevelOptions = ["Low", "Medium", "High"]
    var sexChoice: String?
    var weightChoice: Int?
    var heightChoice: Int?
    var activityChoice: String?
    var birthDateChoice: Date?
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1{ //sex
            sexChoice = sexOptions[row]
        }
        else if pickerView.tag == 3{ //weight
            weightChoice = weightOptions[row]
        }
            
        else if pickerView.tag == 4{ //height
            heightChoice = heightOptions[row]
        }
            
        else if pickerView.tag == 5{ //activity
            activityChoice = activityLevelOptions[row]
        }
        else{ //date
            birthDateChoice = nil //FIX THIS LATER
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (pickerView.tag == 1){
            return sexOptions.count
        }
        else if (pickerView.tag == 3){
            return weightOptions.count
        }
        else if (pickerView.tag == 4){
            return heightOptions.count
        }
        else {
            return activityLevelOptions.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (pickerView.tag == 1){
            return sexOptions[row]
        }
        else if (pickerView.tag == 3){
            return "\(weightOptions[row]) lbs"
        }
        else if (pickerView.tag == 4){
            return "\(heightOptions[row]) inches"
        }
        else {
            return activityLevelOptions[row]
        }
    }
    
    func update(){
        let defaults = UserDefaults.standard
        var weightRow: Int
        var heightRow: Int
        var sexRow: Int
        var activityRow: Int
        
        if (defaults.integer(forKey: "defaultWeightPickerRow") != 0) {
            weightRow = defaults.integer(forKey: "defaultWeightPickerRow")
        }
        else{
            weightRow = 150
        }
        
        if (defaults.integer(forKey: "defaultHeightPickerRow") != 0) {
            heightRow = defaults.integer(forKey: "defaultHeightPickerRow")
        }
        else{
            heightRow = 70
        }
        
        if (defaults.integer(forKey: "defaultSexPickerRow") != 0) {
            sexRow = defaults.integer(forKey: "defaultSexPickerRow")
        }
        else{
            sexRow = 0
        }
        if (defaults.integer(forKey: "defaultActivityLevelPickerRow") != 0) {
            activityRow = defaults.integer(forKey: "defaultActivityLevelPickerRow")
        }
        else{
            activityRow = 0
        }
        
        weight.selectRow(weightRow, inComponent: 0, animated: false)
        height.selectRow(heightRow, inComponent: 0, animated: false)
        sex.selectRow(sexRow, inComponent: 0, animated: false)
        
        sexChoice = sexOptions[sexRow]
        weightChoice = weightOptions[weightRow]
        heightChoice = heightOptions[heightRow]
        activityChoice = activityLevelOptions[activityRow]
        //THIS NEEDS TO BE DONE FOR DATE AS WELL
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        update()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
}
