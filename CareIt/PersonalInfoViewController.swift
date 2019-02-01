//
//  PersonalInfoViewController.swift
//  CareIt
//
//  Created by Annie Liang (student LM) on 1/29/19.
//  Copyright © 2019 Jason Kozarsky (student LM). All rights reserved.
//

import Foundation
import UIKit

class PersonalInfoViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{
    
    @IBOutlet weak var sex: UIPickerView!
    @IBOutlet weak var birthday: UIDatePicker!
    @IBOutlet weak var weight: UIPickerView!
    @IBOutlet weak var height: UIPickerView!
    @IBOutlet weak var activityLevel: UIPickerView!
    
    var sexOptions: [String] = []
    var birthdayOptions: [String] = []
    var weightOptions: [String] = []
    var heightOptions: [String] = []
    var activityLevelOptions: [String] = []
    
    //    func update(){
    //        let defaults = UserDefaults.standard
    //        print(defaults.integer(forKey: "defaultCelsiusPickerRow"))
    //
    //        var row: Int
    //
    //        if (defaults.integer(forKey: "defaultCelsiusPickerRow") != 0) {
    //            row = defaults.integer(forKey: "defaultCelsiusPickerRow")
    //        }
    //        else{
    //            row = temperaturePicker.numberOfRows(inComponent: 0)/2
    //        }
    //
    //        temperaturePicker.selectRow(row, inComponent: 0, animated: false)
    //        pickerView(temperaturePicker, didSelectRow: row, inComponent: 0)
    //    }
    
    override func viewDidLoad() {
        sexOptions = ["Male", "Female", "Other"]
        birthdayOptions = []
        weightOptions = []
        heightOptions = []
        activityLevelOptions = ["Low", "Medium", "High"]
        
        super.viewDidLoad()
        //update()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (pickerView.tag == 1){
            return sexOptions.count
        }
        else if (pickerView.tag == 2){
            return birthdayOptions.count
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
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        if (pickerView.tag == 1){
            return "\(sexOptions[row])"
        }
        else if (pickerView.tag == 2){
            return "\(birthdayOptions[row])"
        }
        else if (pickerView.tag == 3){
            return "\(weightOptions[row])"
        }
        else if (pickerView.tag == 4){
            return "\(heightOptions[row])"
        }
        else {
            return "\(activityLevelOptions[row])"
        }
    }
    
}
