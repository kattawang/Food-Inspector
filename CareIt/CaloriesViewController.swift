//
//  CaloriesViewController.swift
//  CareIt
//
//  Created by Annie Liang (student LM) on 2/8/19.
//  Copyright © 2019 Jason Kozarsky (student LM). All rights reserved.
//

import Foundation
import UIKit
import Firebase

class CaloriesViewController: UIViewController{
    
    @IBOutlet weak var recomCalories: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let now = Date()
        let calendar = Calendar.current
        
        let ref: DatabaseReference!
        
        ref.observeSingleEvent(of: .value, with: { snapshot in
            for child in snapshot.children {
                if let sex = snapshot.value["Sex"] as? String {
                    print(sex)
                }
            }
        }
        
        
        
        //To do: ask jason about getting calories
        
//        let ageComponents = calendar.dateComponents([.year], from: birthday, to: now)
//        let age = ageComponents.year!
//
//        if (sex=="Female") {
//            recomCalories = 10*(weight/2.20462) + 6.25*(height/0.393701) - 5*age - 161
//        }
//        else {
//            recomCalories = 10*(weight/2.20462) + 6.25*(height/0.393701) - 5*age + 5
//        }
//
//        if (activity == "Low") {
//            recomCalories *= 1.2
//        }
//        else if (activity == "Medium") {
//            recomCalories *= 1.3
//        }
//        else {
//            recomCalories *= 1.4
//        }
    }
}
