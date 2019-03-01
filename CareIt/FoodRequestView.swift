//
//  FoodRequestView.swift
//  CareIt
//
//  Created by William Londergan (student LM) on 3/1/19.
//  Copyright © 2019 Jason Kozarsky (student LM). All rights reserved.
//

import UIKit

class FoodRequestView {
    let dismissButton = UIButton()
    let transitionButton = UIButton()
    let foodTitle = UILabel()
    let servingCounter = UILabel()
    let displayView: UIView
    
    init(_ displayView: UIView) {
        self.displayView = displayView
    }
    
    func setup(_ food: Food) {
        displayView.alpha = 1
        displayView.backgroundColor = .white //we should probably figure out what color this actually will be.
        
        let dismissButton = UIButton()
        let transitionButton = UIButton()
        let foodTitle = UILabel()
        let servingCounter = UILabel()
        
        
        dismissButton.addTarget(self, action: #selector(doneButton(_:)), for: .touchUpInside)
        transitionButton.addTarget(self, action: #selector(transButton(_:)), for: .touchUpInside)
    }
    
    @objc func doneButton(_ sender: Any) {
        displayView.removeFromSuperview()
    }
    
    @objc func transButton(_ sender: Any) {
        
    }
}
