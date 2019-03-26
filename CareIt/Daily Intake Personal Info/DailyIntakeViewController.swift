//
//  DailyIntakeViewController.swift
//  CareIt
//
//  Created by Katherine Wang (student LM) on 2/25/19.
//  Copyright © 2019 Jason Kozarsky (student LM). All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseDatabase

class DailyIntakeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var Calendar: UICollectionView!
    
    @IBOutlet weak var Month: UILabel!
    
    @IBOutlet weak var recomCalories: UILabel!
    
    let Months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    var daysInMonths = [31,28,31,30,31,30,31,31,30,31,30,31]
    
    var firstWeekDayOfMonth = 0   //(Sunday-Saturday 1-7)
    
    var currentMonth = String()
    
    //for getting stuff from firebase
    var userInfo: [String: Any]? = [:]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentMonth = Months[month]
        Month.text = "\(currentMonth) \(year)"
        
        firstWeekDayOfMonth=getFirstWeekDay()
        
        //for leap years, make february month of 29 days
        //CHECK
        if month == 1 && year % 4 == 0 {
            daysInMonths[month] = 29
        }
        
        //FIND USERINFO
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let databaseRef = Database.database().reference().child("users\(uid)")
        
        databaseRef.observeSingleEvent(of: .value, with: {snapshot in
            self.userInfo = snapshot.value as? [String: Any] ?? [:]
        })
        
        
        //To do: ask jason about getting calories
        
        //        let ageComponents = calendar.dateComponents([.year], from: birthday, to: now)
        //        let age = ageComponents.year!
        //
        //        if (sex=="Female") {
        //            recomCalories = 10*(weight/2.20462) + 6.25*(height/0.393701) - 5*age - 161
        //        }
        //        else {
        //            recomCalories = 10*(weight/2.20462) + 6.25*(height/0.393701) - 5*age + 5
        //        }
        //
        //        if (activity == "Low") {
        //            recomCalories *= 1.2
        //        }
        //        else if (activity == "Medium") {
        //            recomCalories *= 1.3
        //        }
        //        else {
        //            recomCalories *= 1.4
        //        }
    }
    
    
    func getFirstWeekDay() -> Int {
        let day = ("\(year)-\(month+1)-01".date?.firstDayOfTheMonth.weekday)!
        return day
    }
    

    
   
    func didChangeMonth(monthIndex: Int, currYear: Int) {
        
        //for leap year, make february month of 29 days
        if month == 1 {
            if year % 4 == 0 {
                daysInMonths[month] = 29
            } else {
                daysInMonths[month] = 28
            }
        }
        
        firstWeekDayOfMonth=getFirstWeekDay()
        
        Calendar.reloadData()
    }
    
    
    
    
    
    
    @IBAction func next(_ sender: UIButton) {
        month += 1
        if month > 11 {
            month = 0
            year += 1
        }
        
        Month.text = "\(Months[month]) \(year)"
        didChangeMonth(monthIndex: month, currYear: year)
        
        Calendar.reloadData()
    }
    
    @IBAction func back(_ sender: UIButton) {
        month -= 1
        if month < 0 {
            month = 11
            year -= 1
        }
        
        Month.text = "\(Months[month]) \(year)"
        didChangeMonth(monthIndex: month, currYear: year)
        
        Calendar.reloadData()
       
    }
    
    
    
    //number of items in the collection view, should be current month - 1 to get month index, plus the first days
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //        print(DaysInMonths[month] + firstWeekDayOfMonth - 1)
        return daysInMonths[month] + firstWeekDayOfMonth - 1
    }
    
    
    
    
    
    
    //cell at each day in the collection view
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Calendar", for: indexPath) as! DateCollectionViewCell
        
        
        cell.backgroundColor = UIColor.clear
        cell.DateLabel.textColor = UIColor.black
        
        
        if indexPath.item <= firstWeekDayOfMonth - 2 {
            cell.isHidden=true
        } else {
            let calcDate = indexPath.row-firstWeekDayOfMonth+2
            cell.isHidden=false
            cell.DateLabel.text="\(calcDate)"
        }
        
        
        //hides every cell smaller than one
        if Int(cell.DateLabel.text!)! < 1{
            cell.isHidden = true
        }
        
        
        
        //show weekdays in different color in a disgusting way
        //        switch indexPath.row{
        //        case 5, 6, 12, 13, 19, 20, 26, 27, 33, 34:
        //            if Int(cell.DateLabel.text!)! > 0 {
        //                cell.DateLabel.textColor = UIColor.lightGray
        //            }
        //        default:
        //            break
        //        }
        
        
        //current date marked in red
        //        if month == Months[calendar.component(.month, from: date)-1] && year == calendar.component(.year, from: date) && indexPath.row + 1 + numberOfEmptyBox == day{
        //            cell.backgroundColor = UIColor.red
        //        }
        
        return cell
    }
    
    
    
    
    //did select cell: change cell background to red
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell=collectionView.cellForItem(at: indexPath)
        
        //deselect the current day ?
        //        if month == Months[calendar.component(.month, from: date)-1] && year == calendar.component(.year, from: date) && indexPath.row + 1 + numberOfEmptyBox == day{
        //            cell?.backgroundColor = UIColor.clear
        //        }
        cell?.backgroundColor=UIColor.red
        
        
        //do display nutrient info stuff here
        
    }
    
   

}


//get first day of the month
extension Date {
    var weekday: Int {
        return Calendar.current.component(.weekday, from: self)
    }
    var firstDayOfTheMonth: Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year,.month], from: self))!
    }
}

//get date from string
extension String {
    static var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    var date: Date? {
        return String.dateFormatter.date(from: self)
    }
}
