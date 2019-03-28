//
//  HomeScreenViewController.swift
//  CareIt
//
//  Created by Jason Kozarsky (student LM) on 2/19/19.
//  Copyright © 2019 Jason Kozarsky (student LM). All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class HomeScreenViewController: UIViewController {
    
    var logoutButton = UIButton()
    var personalInfoButton = UIButton()
    var calendarButton = UIButton()
    var cameraButton = UIButton()
    var userInfo: [String : Any] = [:]
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // because we don't want the user to be able to go back further from this screen (without hitting the logout button),
        // the navigation bar is hidden, uses viewDidAppear so that every time this view is segued to the bar is hidden
        navigationController?.navigationBar.isHidden = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DailyIntakeViewController{
            destination.userInfo = self.userInfo
        }
        if let destination = segue.destination as? PersonalInfoViewController{
            destination.userInfo = self.userInfo
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //FIND USERINFO
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let databaseRef = Database.database().reference().child("users\(uid)")
        
        databaseRef.observeSingleEvent(of: .value, with: {snapshot in
            self.userInfo = snapshot.value as? [String: Any] ?? [:]
        })
        
        view.backgroundColor=UIColor(red: 253/255.0, green: 255/255.0, blue: 137/255.0, alpha: 1)

        //sets up the basics for all buttons
        view.addSubview(logoutButton)
        logoutButton.setTitle("Log Out", for: .normal)
        logoutButton.setTitleColor(UIColor.black, for: .normal)
        logoutButton.titleLabel?.font = UIFont(name: "Avenir Medium", size: 29)
        logoutButton.addTarget(self, action: #selector(logoutTouchedUp), for: .touchUpInside)
        logoutButton.backgroundColor=UIColor(red: 0/255, green: 193/255, blue: 83/255, alpha: 1.0)
        logoutButton.setTitleColor(UIColor.white, for: .normal)
        
        view.addSubview(personalInfoButton)
//        personalInfoButton.setTitle("Personal Info", for: .normal)
//        personalInfoButton.setTitleColor(UIColor.black, for: .normal)
//        personalInfoButton.titleLabel?.font = UIFont(name: "Avenir Medium", size: 29)
        personalInfoButton.addTarget(self, action: #selector(personalInfoTouchedUp), for: .touchUpInside)
        personalInfoButton.setBackgroundImage(UIImage(named: "Personal Info"), for: .normal)
        
        view.addSubview(calendarButton)
//        calendarButton.setTitle("Daily Intake", for: .normal)
//        calendarButton.setTitleColor(UIColor.black, for: .normal)
//        calendarButton.titleLabel?.font = UIFont(name: "Avenir Medium", size: 29)
        calendarButton.addTarget(self, action: #selector(calendarTouchedUp), for: .touchUpInside)
        calendarButton.setImage(UIImage(named: "Daily Intake"), for: .normal)
        
        view.addSubview(cameraButton)
//        cameraButton.setTitle("Barcode Scanner", for: .normal)
//        cameraButton.setTitleColor(UIColor.black, for: .normal)
//        cameraButton.titleLabel?.font = UIFont(name: "Avenir Medium", size: 30)
        cameraButton.addTarget(self, action: #selector(cameraTouchedUp), for: .touchUpInside)
        cameraButton.setImage(UIImage(named: "Barcode"), for: .normal)
         
        //constraints for buttons
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoutButton.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
        logoutButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        logoutButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        personalInfoButton.translatesAutoresizingMaskIntoConstraints = false
        personalInfoButton.widthAnchor.constraint(equalToConstant: view.frame.height/10).isActive = true
        personalInfoButton.heightAnchor.constraint(equalToConstant: view.frame.height/10).isActive = true
        personalInfoButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        personalInfoButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        
        
//        personalInfoButton.titleEdgeInsets = UIEdgeInsetsMake(0, -(personalInfoButton.imageView!.frame.size.width+view.frame.width/4), -(personalInfoButton.imageView!.frame.size.height), 0)
        
        calendarButton.translatesAutoresizingMaskIntoConstraints = false
        calendarButton.widthAnchor.constraint(equalToConstant: 0.25*view.frame.height).isActive = true
        calendarButton.heightAnchor.constraint(equalToConstant: 0.25*view.frame.height).isActive = true
        calendarButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        calendarButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 200+(view.frame.height-300)/2).isActive = true
        
        calendarButton.titleEdgeInsets = UIEdgeInsetsMake(0, -(calendarButton.imageView!.frame.size.width+view.frame.width/4), -(calendarButton.imageView!.frame.size.height), 0)
        
        cameraButton.translatesAutoresizingMaskIntoConstraints = false
        cameraButton.widthAnchor.constraint(equalToConstant: 0.25*view.frame.height).isActive = true
        cameraButton.heightAnchor.constraint(equalToConstant: 0.25*view.frame.height).isActive = true
        cameraButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        cameraButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 200).isActive = true
        cameraButton.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        cameraButton.titleLabel?.textAlignment = NSTextAlignment.center
        cameraButton.setTitleColor(.black, for: .normal)
        
        cameraButton.titleEdgeInsets = UIEdgeInsetsMake(0, -(cameraButton.imageView!.frame.size.width+view.frame.width/4), -(cameraButton.imageView!.frame.size.height), 0)
//        let titleSize = NSString(string: cameraButton.titleLabel!.text!).size(withAttributes: [NSAttributedStringKey.font : cameraButton.titleLabel!.font])
//        cameraButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0)
        
    }
    
    @objc func logoutTouchedUp() {
        //signs the user out and uses the navigation controller to segue back to the launch screen
        try! Auth.auth().signOut()
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func personalInfoTouchedUp() {
        //segues to the personal info view controller
        self.performSegue(withIdentifier: "toPersonalInfo", sender: self)
        navigationController?.navigationBar.isHidden = false
    }
    
    @objc func calendarTouchedUp(){
        //segues to the daily intake view controller
        self.performSegue(withIdentifier: "toDailyIntake", sender: self)
        navigationController?.navigationBar.isHidden = false
    }
    
    @objc func cameraTouchedUp(){
        //segues to the personal info view controller
        self.performSegue(withIdentifier: "toCamera", sender: self)
        navigationController?.navigationBar.isHidden = false
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
