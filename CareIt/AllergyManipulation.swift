//
//  AllergyManipulation.swift
//  CareIt
//
//  Created by Jason Kozarsky (student LM) on 3/18/19.
//  Copyright © 2019 Jason Kozarsky (student LM). All rights reserved.
//

import Foundation

class AllergyManipulation {
    
    static func getAllergyList(_ generalAllergies: [String]) -> [String] {
        var specificAllergies: [String] = []
        
        for allergy in generalAllergies {
            switch allergy{
            case "Fruit":
                specificAllergies.append(contentsOf: ["apple", "apricot", "avocado", "banana", "berry", "berrie", "fruit", "cherries", "date", "fig", "grape", "kiwi", "lemon", "lime", "orange", "mango", "nectarine", "melon", "papaya", "peach","pear","persimmon","plantain", "plum", "pomegranite", "prune", "rhubarb", "tangelo", "tangerine"])
                break
            default:
                break
            }
        }
        
        return specificAllergies
    }
    
    static func getIngredientsArray(_ foodString: String) -> [String] {
        
        var fullNameArr = foodString.components(separatedBy: " ")
        var ingredients = [String]()
        
        for i in 0 ..< (fullNameArr.count) {
            
            if fullNameArr[i].range(of: ",") == nil && i < (fullNameArr.count-1) && fullNameArr[i+1].range(of: "[" ) == nil && fullNameArr[i+1].range(of: "(") == nil {
                
                fullNameArr[i+1] = fullNameArr[i] + " " + fullNameArr[i+1]
            }
            else {
                ingredients.append(fullNameArr[i])
            }
        }
        
        //this is hella ugly so if anyone wants to work with regexes to redo this, go ahead
        ingredients = ingredients.map {element in
            return element.replacingOccurrences(of: ",", with: "").replacingOccurrences(of: "[", with: "").replacingOccurrences(of: "(", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: ".", with: "").replacingOccurrences(of: "]", with: "").replacingOccurrences(of: "CONTAINS ONE OR MORE OF THE FOLLOWING: ", with: "").replacingOccurrences(of: "-", with: "")
        }
        
        return ingredients
    }
}
