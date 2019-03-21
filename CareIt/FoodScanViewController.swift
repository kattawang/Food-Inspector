//
//  FoodScanViewController.swift
//  CareIt
//
//  Created by William Londergan (student LM) on 3/18/19.
//  Copyright © 2019 Jason Kozarsky (student LM). All rights reserved.
//

import UIKit

class FoodScanViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var goodBadView: UIView!
    
    @IBOutlet weak var servingsView: UILabel!
    
    @IBOutlet weak var stepper: UIStepper!
    
    @IBOutlet weak var doneButton: UIButton!
    
    var food: Food?
    
    func setupView(_ food: Food?) {
        self.food = food
        if let food = food {
            
            if let allergies = UserAllergies.userIsAllergicTo(food) {
                allergyView(allergies)
            }
            else {
                okayView()
            }
        }
        else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func allergyView(_ allergies: [String]) {
        
    }
    
    func okayView() {
        let 
    }
    
}
