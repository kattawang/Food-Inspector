//
//  UserAllergies.swift
//  CareIt
//
//  Created by Jason Kozarsky (student LM) on 3/5/19.
//  Copyright © 2019 Jason Kozarsky (student LM). All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class UserAllergies {
    
    static func userIsAllergicTo(_ food: Food, completion: @escaping (_ matches: [String]) -> Void){
        var userInformation: [String: Any]? = [:]
        
        //this gets the user's allergies from Firebase
        guard let uid = Auth.auth().currentUser?.uid else {fatalError()}
        let databaseRef = Database.database().reference().child("users\(uid)")
        
        databaseRef.observeSingleEvent(of: .value, with: {snapshot in
            userInformation = snapshot.value as? [String: Any] ?? [:]
            //uses the user allergies from firebase to get more detailed list of allergies
            guard let userInfo = userInformation else {print("abort"); return}
            guard let userAllergies = userInfo["Allergies"] else {print("abort"); return}
            let allergies = AllergyManipulation.getAllergyList(userAllergies as! [String])
            
            print(allergies)
            
            var conflictingAllergies: [String] = []
            let ingredientsList: [String] = AllergyManipulation.getIngredientsArray(food.ing.desc)
            
            //compares the allergies with the ingredients for a match, uses nested
            //for loops in case the allergy is not the complete name of the ingredient
            for allergy in allergies{
                for ingredient in ingredientsList{
                    if ingredient.lowercased().contains(allergy.lowercased()){
                        conflictingAllergies.append(ingredient)
                    }
                }
            }
            completion(conflictingAllergies)
            
        })
    
    }
    
    static func getAllergies(_ completion: @escaping(_ allergies: [String]) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {fatalError()}
        let databaseRef = Database.database().reference().child("users\(uid)")
        databaseRef.observeSingleEvent(of: .value, with: {snapshot in
            let userInformation = snapshot.value as? [String: Any] ?? [:]
            //uses the user allergies from firebase to get more detailed list of allergies
            guard let userAllergies = userInformation["Allergies"] else {print("abort"); return}
            let allergies = AllergyManipulation.getAllergyList(userAllergies as! [String])
            completion(allergies)
        })
    }

}
