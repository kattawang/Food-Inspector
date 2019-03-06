//
//  UserAllergies.swift
//  CareIt
//
//  Created by Jason Kozarsky (student LM) on 3/5/19.
//  Copyright © 2019 Jason Kozarsky (student LM). All rights reserved.
//

import UIKit

class UserAllergies {
    
    let food: Food
    let allergies: [String]
    
    init(food: Food, allergies: [String]){
        self.food = food
        self.allergies = allergies
    }
    
    func userIsAllergicTo() -> [String]{
        var conflictingAllergies: [String] = []
        
        let ingredientsList: [String] = StringManipulation.manipulateString(food.ing.desc)
        
        for allergy in allergies{
            for ingredient in ingredientsList{
                if ingredient.contains(allergy){
                    conflictingAllergies.append(ingredient)
                }
            }
        }
        
        return conflictingAllergies
    }
    
}

