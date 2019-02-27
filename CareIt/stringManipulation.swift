//
//  stringManipulation.swift
//  CareIt
//
//  Created by Prince Geutler (student LM) on 2/27/19.
//  Copyright © 2019 Jason Kozarsky (student LM). All rights reserved.
//
//
//  stringManipulation.swift
//  CareIt
//
//  Created by Prince Geutler (student LM) on 2/7/19.
//  Copyright © 2019 Jason Kozarsky (student LM). All rights reserved.
//


import Foundation


class StringManipulation{
    
    
    func manipulateString(foodString: String) -> [String] {
        
        let Ingredients    = foodString
        var fullNameArr = Ingredients.components(separatedBy: " ")
        var ingredients = [String]()
        
        
        
        for i in 0 ..< (fullNameArr.count) {
            
            if fullNameArr[i].range(of: ",") == nil && i < (fullNameArr.count-1) && fullNameArr[i+1].range(of: "[" ) == nil && fullNameArr[i+1].range(of: "(") == nil {
                
                fullNameArr[i+1] = fullNameArr[i] + " " + fullNameArr[i+1]
                
                
            }
            else {
                
                ingredients.append(fullNameArr[i])
            }
            
            
            
        }
        for x in 0 ..< (ingredients.count) {
            
            ingredients[x] = ingredients[x].replacingOccurrences(of: ",", with: "")
            ingredients[x] = ingredients[x].replacingOccurrences(of: "[", with: "")
            ingredients[x] = ingredients[x].replacingOccurrences(of: "(", with: "")
            ingredients[x] = ingredients[x].replacingOccurrences(of: ")", with: "")
            ingredients[x] = ingredients[x].replacingOccurrences(of: ".", with: "")
            ingredients[x] = ingredients[x].replacingOccurrences(of: "]", with: "")
            ingredients[x] = ingredients[x].replacingOccurrences(of: "CONTAINS ONE OR MORE OF THE FOLLOWING: ", with: "")
            ingredients[x] = ingredients[x].replacingOccurrences(of: "-", with: "")
            
            
            
            
            
            print(ingredients[x])
            
        }
        return ingredients
    }
}

