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
    var warningButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        
        view.addSubview(logoutButton)
        logoutButton.setTitle("Log Out", for: .normal)
        logoutButton.setTitleColor(UIColor.black, for: .normal)
        logoutButton.titleLabel?.font = UIFont(name: "Avenir Medium", size: 29)
        logoutButton.addTarget(self, action: #selector(logoutTouchedUp), for: .touchUpInside)
        logoutButton.backgroundColor=UIColor(red: 211.65/255, green: 0/255, blue: 0/255, alpha: 1.0)
        logoutButton.setTitleColor(UIColor.white, for: .normal)
        logoutButton.layer.cornerRadius = 20
        
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoutButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -(view.frame.size.height-180)/8).isActive = true
        logoutButton.widthAnchor.constraint(equalToConstant: view.frame.size.width/2).isActive = true
        logoutButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        view.addSubview(warningButton)
        warningButton.setTitle("User Warning", for: .normal)
        warningButton.setTitleColor(UIColor.black, for: .normal)
        warningButton.titleLabel?.font = UIFont(name: "Avenir Medium", size: 29)
        warningButton.addTarget(self, action: #selector(warningTouchedUp), for: .touchUpInside)
        warningButton.backgroundColor=UIColor(red: 211.65/255, green: 0/255, blue: 0/255, alpha: 1.0)
        warningButton.setTitleColor(UIColor.white, for: .normal)
        warningButton.layer.cornerRadius = 20
        
        warningButton.translatesAutoresizingMaskIntoConstraints = false
        warningButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        warningButton.bottomAnchor.constraint(equalTo: logoutButton.topAnchor, constant: -(view.frame.size.height-180)/8).isActive = true
        warningButton.widthAnchor.constraint(equalToConstant: view.frame.size.width/2).isActive = true
        warningButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        view.addSubview(personalInfoButton)
        personalInfoButton.setTitle("Personal Info", for: .normal)
        personalInfoButton.setTitleColor(UIColor.black, for: .normal)
        personalInfoButton.titleLabel?.font = UIFont(name: "Avenir Medium", size: 29)
        personalInfoButton.addTarget(self, action: #selector(personalInfoTouchedUp), for: .touchUpInside)
        personalInfoButton.backgroundColor=UIColor(red: 211.65/255, green: 0/255, blue: 0/255, alpha: 1.0)
        personalInfoButton.setTitleColor(UIColor.white, for: .normal)
        personalInfoButton.layer.cornerRadius = 20
        
        personalInfoButton.translatesAutoresizingMaskIntoConstraints = false
        personalInfoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        personalInfoButton.bottomAnchor.constraint(equalTo: warningButton.topAnchor, constant: -(view.frame.size.height-180)/8).isActive = true
        personalInfoButton.widthAnchor.constraint(equalToConstant: view.frame.size.width/2).isActive = true
        personalInfoButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        let logoImageView = UIImageView(frame: CGRect(x: (view.frame.width-5*view.frame.height/12)/2, y: 30, width: 5*view.frame.height/12, height: 5*view.frame.height/12))
        logoImageView.image = UIImage(named: "red-apple.png")
        self.view.addSubview(logoImageView)
        
    }
    
    @objc func personalInfoTouchedUp(){
        navigationController?.navigationBar.isHidden = false
        self.performSegue(withIdentifier: "toPersonalInfo", sender: self)
    }
    
    @objc func logoutTouchedUp(){
        try! Auth.auth().signOut()
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func warningTouchedUp(){
        navigationController?.navigationBar.isHidden = false
        self.performSegue(withIdentifier: "toWarning", sender: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }

}
