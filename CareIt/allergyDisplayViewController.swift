//
//  allergyDisplayViewController.swift
//  CareIt
//
//  Created by Prince Geutler (student LM) on 3/15/19.
//  Copyright © 2019 Jason Kozarsky (student LM). All rights reserved.
//

import UIKit

class allergyDisplayViewController: UIViewController {

    @IBOutlet weak var allergyDisplay: UILabel!
    
    var allergyselected = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let x = allergyselected.joined(separator: ", ")
        print (x)
        allergyDisplay.text = x
        
        // Do any additional setup after loading the view.
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
