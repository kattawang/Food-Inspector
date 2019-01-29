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
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        <#code#>
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        <#code#>
    }
    
}
