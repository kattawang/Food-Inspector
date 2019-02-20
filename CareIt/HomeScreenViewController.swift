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

    @objc func logoutTouchedUp() {
        try! Auth.auth().signOut()
        self.dismiss(animated: false, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(logoutButton)
        logoutButton.setTitle("Logout", for: .normal)
        logoutButton.setTitleColor(UIColor.black, for: .normal)
        logoutButton.backgroundColor = UIColor.yellow
        logoutButton.titleLabel?.font = UIFont(name: "helvetica neue", size: 30)
        logoutButton.addTarget(self, action: #selector(logoutTouchedUp), for: .touchUpInside)
        
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoutButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        
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
