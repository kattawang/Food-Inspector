//
//  HomeScreenViewController.swift
//  CareIt
//
//  Created by Jason Kozarsky (student LM) on 2/19/19.
//  Copyright © 2019 Jason Kozarsky (student LM). All rights reserved.
//

import UIKit
import FirebaseAuth

class HomeScreenViewController: UIViewController {
    
    var logoutButton = UIButton()
    var personalInfoButton = UIButton()
    var calendarButton = UIButton()
    var cameraButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //sets up the basics for all buttons
        view.addSubview(logoutButton)
        logoutButton.setTitle("Logout", for: .normal)
        logoutButton.setTitleColor(UIColor.black, for: .normal)
        logoutButton.backgroundColor = UIColor.blue
        logoutButton.titleLabel?.font = UIFont(name: "Rockwell", size: 29)
        logoutButton.addTarget(self, action: #selector(logoutTouchedUp), for: .touchUpInside)
        
        view.addSubview(personalInfoButton)
        personalInfoButton.setTitle("Personal Info", for: .normal)
        personalInfoButton.setTitleColor(UIColor.black, for: .normal)
        personalInfoButton.backgroundColor = UIColor.blue
        personalInfoButton.titleLabel?.font = UIFont(name: "Rockwell", size: 29)
        personalInfoButton.addTarget(self, action: #selector(personalInfoTouchedUp), for: .touchUpInside)
        
        view.addSubview(calendarButton)
        calendarButton.setTitle("Daily Intake", for: .normal)
        calendarButton.setTitleColor(UIColor.black, for: .normal)
        calendarButton.backgroundColor = UIColor.blue
        calendarButton.titleLabel?.font = UIFont(name: "Rockwell", size: 29)
        calendarButton.addTarget(self, action: #selector(calendarTouchedUp), for: .touchUpInside)
        
        view.addSubview(cameraButton)
        cameraButton.setTitle("Barcode Scanner", for: .normal)
        cameraButton.setTitleColor(UIColor.black, for: .normal)
        cameraButton.backgroundColor = UIColor.blue
        cameraButton.titleLabel?.font = UIFont(name: "Rockwell", size: 30)
        cameraButton.addTarget(self, action: #selector(cameraTouchedUp), for: .touchUpInside)
        
        //constraints for buttons
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoutButton.topAnchor.constraint(equalTo: personalInfoButton.bottomAnchor, constant: 50).isActive = true
        
        personalInfoButton.translatesAutoresizingMaskIntoConstraints = false
        personalInfoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        personalInfoButton.topAnchor.constraint(equalTo: calendarButton.bottomAnchor, constant: 50).isActive = true
        
        calendarButton.translatesAutoresizingMaskIntoConstraints = false
        calendarButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        calendarButton.topAnchor.constraint(equalTo: cameraButton.bottomAnchor, constant: 50).isActive = true
        cameraButton.translatesAutoresizingMaskIntoConstraints = false
        cameraButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        cameraButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
    }
    
    @objc func logoutTouchedUp() {
        try! Auth.auth().signOut()
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func personalInfoTouchedUp() {
        self.performSegue(withIdentifier: "toPersonalInfo", sender: self)
    }
    
    @objc func calendarTouchedUp(){
        self.performSegue(withIdentifier: "toCalendar", sender: self)
    }
    
    @objc func cameraTouchedUp(){
        self.performSegue(withIdentifier: "toCamera", sender: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ViewController {
    
    @IBAction func backToHomeScreenViewController(_ segue: UIStoryboardSegue) {
    }
}
