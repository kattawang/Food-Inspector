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
    var personalInfoButton = UIButton()

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
        
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoutButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
        logoutButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        logoutButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        
        view.addSubview(personalInfoButton)
        personalInfoButton.setTitle("Personal Info", for: .normal)
        personalInfoButton.setTitleColor(UIColor.black, for: .normal)
        personalInfoButton.titleLabel?.font = UIFont(name: "Avenir Medium", size: 29)
        personalInfoButton.addTarget(self, action: #selector(personalInfoTouchedUp), for: .touchUpInside)
        personalInfoButton.backgroundColor=UIColor(red: 0/255, green: 193/255, blue: 83/255, alpha: 1.0)
        personalInfoButton.setTitleColor(UIColor.white, for: .normal)
        
        //CHANGE THESE CONSTRAINTS
        personalInfoButton.translatesAutoresizingMaskIntoConstraints = false
        personalInfoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        personalInfoButton.bottomAnchor.constraint(equalTo: logoutButton.topAnchor, constant: -100).isActive = true
        personalInfoButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        personalInfoButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    @objc func personalInfoTouchedUp(){
        self.performSegue(withIdentifier: "toPersonalInfo", sender: self)
    }
    
    @objc func logoutTouchedUp(){
        try! Auth.auth().signOut()
        navigationController?.popToRootViewController(animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }

}
