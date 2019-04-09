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
            
            // the below line forces the view to load so that the outlets do not return nil
            _ = self.view
            
            self.titleLabel.lineBreakMode = .byWordWrapping
            self.titleLabel.numberOfLines = 0
            self.titleLabel.text = sanitizeTitle(food.desc.name)            
            let allergies = UserAllergies.userIsAllergicTo(food)
            
            if allergies.count != 0 {
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
        print("we in not ok")
        let alertLabel = UILabel()
        alertLabel.font = UIFont(name: "Helvetica Neue", size: 30)
        alertLabel.text = "Unsafe to Eat ☠"
        alertLabel.translatesAutoresizingMaskIntoConstraints = false
        alertLabel.centerXAnchor.constraint(equalTo: goodBadView.centerXAnchor).isActive = true
        alertLabel.centerYAnchor.constraint(equalTo: goodBadView.topAnchor, constant: 10).isActive = true
        view.backgroundColor = .red
    }
    
    func okayView() {
        print("we in ok")
        let okayLabel = UILabel()
        okayLabel.font = UIFont(name: "Helvetica Neue", size: 30)
        okayLabel.text = "Safe to Eat 🍴"
        okayLabel.translatesAutoresizingMaskIntoConstraints = false
        goodBadView.backgroundColor = .clear
        view.backgroundColor = UIColor(displayP3Red: 163/255, green: 252/255, blue: 90/255, alpha: 1)
        goodBadView.addSubview(okayLabel)
        okayLabel.centerXAnchor.constraint(equalTo: goodBadView.centerXAnchor).isActive = true
        okayLabel.centerYAnchor.constraint(equalTo: goodBadView.centerYAnchor).isActive = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
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
