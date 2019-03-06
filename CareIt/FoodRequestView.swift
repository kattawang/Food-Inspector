//
//  FoodRequestView.swift
//  CareIt
//
//  Created by William Londergan (student LM) on 3/1/19.
//  Copyright © 2019 Jason Kozarsky (student LM). All rights reserved.
//

import UIKit

extension UIView {
    var penis: Bool {
        get {
            return self.translatesAutoresizingMaskIntoConstraints
        }
        set(val) {
            self.translatesAutoresizingMaskIntoConstraints = val
        }
    }
}

class FoodRequestView {
    let dismissButton = UIButton()
    let transitionButton = UIButton()
    let foodTitle = UILabel()
    let warningView = UIView()
    let displayView: UIView
    let food: Food
    
    init(_ displayView: UIView, food: Food) {
        self.displayView = displayView
        self.displayView.addSubview(warningView)
        self.displayView.addSubview(dismissButton)
        self.food = food
    }
    
    func setup() {
        warningView.centerXAnchor.constraint(equalTo: displayView.centerXAnchor).isActive = true
        
        displayView.alpha = 1
        displayView.backgroundColor = .white //we should probably figure out what color this actually will be
        
        displayView.addSubview(foodTitle)
        
        foodTitle.penis = false
        foodTitle.topAnchor.constraint(equalTo: displayView.topAnchor, constant: 10).isActive = true
        foodTitle.widthAnchor.constraint(equalTo: displayView.widthAnchor, constant: -20).isActive = true
        foodTitle.centerXAnchor.constraint(equalTo: displayView.centerXAnchor).isActive = true
        
        foodTitle.font = UIFont(name: "Helvetica Neue", size: 30)
        foodTitle.text = process(food.desc.name)
        
        warningView.topAnchor.constraint(equalTo: displayView.bottomAnchor, constant: 10).isActive = true
        
        if let allergies = userAllergic() {
            
            let warningLabel = UILabel()
            warningLabel.penis = false
            warningLabel.text = "Unsafe to Eat 💀"
            warningLabel.font = UIFont(name: "Helvetica Neue", size: 30)
            warningLabel.backgroundColor = .red
            warningLabel.textColor = .white
            warningView.addSubview(warningLabel)
            warningLabel.topAnchor.constraint(equalTo: warningView.topAnchor, constant: 10).isActive = true
            warningLabel.centerXAnchor.constraint(equalTo: warningView.centerXAnchor).isActive = true
        } else {

            let okayLabel = UILabel()
            okayLabel.penis = false
            okayLabel.text = "Safe to Eat 🍴"
            okayLabel.font = UIFont(name: "Helvetica Neue", size: 30)
            okayLabel.backgroundColor = .green
            okayLabel.textColor = .white
            warningView.addSubview(okayLabel)
            okayLabel.centerXAnchor.constraint(equalTo: warningView.centerXAnchor).isActive = true
            okayLabel.topAnchor.constraint(equalTo: warningView.topAnchor, constant: 10).isActive = true
        }
        
        
        dismissButton.addTarget(self, action: #selector(doneButton(_:)), for: .touchUpInside)
        transitionButton.addTarget(self, action: #selector(transButton(_:)), for: .touchUpInside)
    }
    
    @objc func doneButton(_ sender: Any) {
        displayView.removeFromSuperview()
    }
    
    @objc func transButton(_ sender: Any) {
        
    }
    
    func userAllergic() -> [String]? {
        if Double.random(in: 0...1) > 0.5{
            return nil
        } else {
            return ["sadness", "unhappiness", "tears"]
        }
    }
    
}

func process(_ title: String) -> String {
    //remove all UPC: stuff
    let separated = title.split(separator: " ")
    let filtered = separated.filter {arg in
        return Int64(arg) == nil && arg != "UPC:"
    }
    return filtered.joined(separator: " ").replacingOccurrences(of: ",", with: "")
}

