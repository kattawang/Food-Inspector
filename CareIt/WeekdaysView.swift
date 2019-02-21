//
//  WeekdaysView.swift
//  CareIt
//
//  Created by Annie Liang (student LM) on 2/19/19.
//  Copyright © 2019 Jason Kozarsky (student LM). All rights reserved.
//

import UIKit

class WeekdaysView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        
        setupViews()
    }
    
    func setupViews() {
        addSubview(myStackView)
        
        myStackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        myStackView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        myStackView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        myStackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        var daysArr = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
        for i in 0..<7 {
            let lbl=UILabel()
            lbl.text=daysArr[i]
            myStackView.addArrangedSubview(lbl)
        }
    }
    
    let myStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    } ()
}
