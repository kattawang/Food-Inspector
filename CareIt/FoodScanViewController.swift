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
            // hello kitty
            self.titleLabel.text = sanitizeTitle(food.desc.name)
            
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
        let alertLabel = UILabel()
        alertLabel.font = UIFont(name: "Helvetica Neue", size: 30)
        alertLabel.text = "Unsafe to Eat ☠"
        alertLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func okayView() {
        let okayLabel = UILabel()
        okayLabel.font = UIFont(name: "Helvetica Neue", size: 30)
        okayLabel.text = "Safe to Eat 🍴"
        okayLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
}

func sanitizeTitle(_ title: String) -> String {
    //remove all UPC: stuff
    let separated = title.split(separator: " ")
    let filtered = separated.filter {arg in
        return Int64(arg) == nil && arg != "UPC:"
    }
    return filtered.joined(separator: " ").replacingOccurrences(of: ",", with: "")
}
