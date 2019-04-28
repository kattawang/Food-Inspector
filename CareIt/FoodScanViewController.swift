//
//  FoodScanViewController.swift
//  CareIt
//
//  Created by William Londergan (student LM) on 3/18/19.
//  Copyright © 2019 Jason Kozarsky (student LM). All rights reserved.
//

import UIKit

class FoodScanViewController: UIViewController {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var goodBadView: UIView!
    
    @IBOutlet weak var servingsView: UILabel!
    
    @IBOutlet weak var stepper: UIStepper!
    
    @IBOutlet weak var doneButton: UIButton!
    
    var food: Food?
    
    @IBAction func stepperTapped(_ sender: UIStepper) {
        if stepper.value == 1.0 {
            servingsView.text = "1 Serving"
        }
        else {
            servingsView.text = "\(Int(stepper.value)) Servings"
        }
    }
    
    func setupView(_ food: Food?) {
        self.food = food
        if let food = food {
            
            // the below line forces the view to load so that the outlets do not return nil
            _ = self.view
            
            self.titleLabel.lineBreakMode = .byWordWrapping
            self.titleLabel.numberOfLines = 0
            self.titleLabel.text = sanitizeTitle(food.desc.name)
            var allergies: [String] = []
            UserAllergies.userIsAllergicTo(food) {matches in
                print(matches)
                allergies = matches
                if allergies.count != 0 {
                    self.allergyView(allergies)
                }
                else {
                    self.okayView()
                }
            }
            
            
        }
        else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stepper.maximumValue = 100
        stepper.minimumValue = 1
        print(getCalories())
    }

    
    func allergyView(_ allergies: [String]) {
        let alertLabel = UILabel()
        alertLabel.font = UIFont(name: "Helvetica Neue", size: 30)
        alertLabel.text = "Unsafe to Eat ☠"
        alertLabel.translatesAutoresizingMaskIntoConstraints = false
        goodBadView.addSubview(alertLabel)
        goodBadView.backgroundColor = .red
        alertLabel.centerXAnchor.constraint(equalTo: goodBadView.centerXAnchor).isActive = true
        alertLabel.topAnchor.constraint(equalTo: goodBadView.topAnchor, constant: 30).isActive = true
        
        let allergyLabel = UILabel()
        allergyLabel.font = UIFont(name: "Helvetica Neue", size: 24)
        allergyLabel.text = allergies.reduce("Matches:\n", {$0 + "\n" + $1})
        allergyLabel.textAlignment = .center
        allergyLabel.numberOfLines = 0
        allergyLabel.translatesAutoresizingMaskIntoConstraints = false
        goodBadView.addSubview(allergyLabel)
        
        allergyLabel.widthAnchor.constraint(equalToConstant: goodBadView.frame.width).isActive = true
        allergyLabel.centerXAnchor.constraint(equalTo: goodBadView.centerXAnchor).isActive = true
        allergyLabel.topAnchor.constraint(equalTo: alertLabel.bottomAnchor, constant: 40).isActive = true
        
        view.backgroundColor = .red
    }
    
    func okayView() {
        let okayLabel = UILabel()
        okayLabel.font = UIFont(name: "Helvetica Neue", size: 30)
        okayLabel.text = "Safe to Eat 🍴"
        okayLabel.translatesAutoresizingMaskIntoConstraints = false
        goodBadView.backgroundColor = .clear
        view.backgroundColor = UIColor(displayP3Red: 163/255, green: 252/255, blue: 90/255, alpha: 1)
        goodBadView.addSubview(okayLabel)
        okayLabel.centerXAnchor.constraint(equalTo: goodBadView.centerXAnchor).isActive = true
        okayLabel.centerYAnchor.constraint(equalTo: goodBadView.centerYAnchor).isActive = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if navigationController?.navigationBar.isHidden == true{
            navigationController?.navigationBar.isHidden = false
        }
        
        self.doneButton.titleLabel?.text = "Eat"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! DailyIntakeViewController
        
        destination.consumedCalories += Double(getCalories())
    }
    
    func getCalories() -> Int {
        var calories = 0
        
        if let food = self.food{
            for nutrient in food.nutrients{
                if nutrient.name == "Energy"{
                    return Int(nutrient.measures[0].value) ?? 0
                }
                else if nutrient.name == "Protein"{
                    calories += 4*(Int(nutrient.measures[0].value) ?? 0)
                }
                else if nutrient.name == "Carbohydrate, by difference"{
                    calories += 4*(Int(nutrient.measures[0].value) ?? 0)
                }
                else if nutrient.name == "Total lipid (fat)"{
                    calories += 9*(Int(nutrient.measures[0].value) ?? 0)
                }
            }
        }
        return calories
    }
    
    
}

func sanitizeTitle(_ title: String) -> String {
    //remove all UPC: stuff
    let separated = title.split(separator: " ")
    let filtered = separated.filter {arg in
        return Int64(arg) == nil && arg != "UPC:"
    }
    return filtered.joined(separator: " ").replacingOccurrences(of: ",", with: "")
}
