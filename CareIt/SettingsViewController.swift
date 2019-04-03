//
//  SettingsViewController.swift
//  CareIt
//
//  Created by Jason Kozarsky (student LM) on 4/2/19.
//  Copyright © 2019 Jason Kozarsky (student LM). All rights reserved.
//

import UIKit
import FirebaseAuth

class SettingsViewController: UIViewController {
    
    var logoutButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        
        view.addSubview(logoutButton)
        logoutButton.setTitle("Log Out", for: .normal)
        logoutButton.setTitleColor(UIColor.black, for: .normal)
        logoutButton.titleLabel?.font = UIFont(name: "Avenir Medium", size: 29)
        logoutButton.addTarget(self, action: #selector(logoutTouchedUp), for: .touchUpInside)
        logoutButton.backgroundColor=UIColor(red: 0/255, green: 193/255, blue: 83/255, alpha: 1.0)
        logoutButton.setTitleColor(UIColor.white, for: .normal)
    }
    
    @objc func logoutTouchedUp(){
        try! Auth.auth().signOut()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }

}
