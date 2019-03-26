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
            case "Vegetable":
                specificAllergies.append(contentsOf: ["amaranth", "arugula leaves", "artichoke", "asparagus", "bamboo shoots", "beans", "beets", "cowpeas or black-eyed peas","broccoli","broccoflower","Brussels sprouts","Cabbage","Capers","Carrots","Cassava or manioc", "Cauliflower", "Celery", "Chard", "Collard greens", "Corn", "Cucumber", "Cucumber, kim chee", "Dandelion greens", "Eggplant", "Endive or escarole", "Jimaca or yambean", "Kale", "Kohlrabi", "Leeks", "Lentils", "Lettuce", "Mushrooms", "Mustard greens", "Okra", "Onions", "Palm hearts", "Parsley", "Parsnips", "Peas", "Peppers", "Poi", "Potatoes", "Pumpkin", "Radicchio", "Radishes", "Rubataga", "Sauerkraut", "Seaweed", "Shallots", "Soybeans", "Tofu", "Soy products", "Spinach", "Squash", "Sweet potatoes", "Taro shoots", "Tomatillo", "Tomato", "Turnips", "Water chestnuts", "Watercress"])
                break
            case "Nuts":
                specificAllergies.append(contentsOf: ["Almonds", "Beechnuts", "Brazil nuts", "Breadfruits seeds", "Butternuts", "Cashews", "Coconut", "Chestnuts", "Flaxseeds or linseeds", "Gingko nuts", "Hazelnuts or filberts", "Hickorynuts", "Macadamis", "Mixed nuts", "Peanuts", "Pecans", "Pine nuts or pignolia", "Pistachios", "Pumpkin or squash seeds", "Sesame", "Soy nuts", "Sunflower seeds", "Trail mix", "Walnuts"])
                break
            case "Dairy":
                specificAllergies.append(contentsOf:["Butter", "Imitation cheese", "Cottage Cheese", "Cream cheese", "Processed cheese", "Soy cheese", "Cream", "Sour Cream", "Imitation cream", "Fluid milk", "Canned", "Dried Milk", "Goat milk", "Eggnog", "Soy", "Yogurt", "Soy Yogurt"])
                break
            case "Seafood":
                specificAllergies.append(contentsOf: ["Fish", "Cod", "Eel", "Fish fillets", "Flounder", "Grouper", "Haddock", "Halibut", "Herring", "Jack mackerel", "Octopus", "Perch", "Pacific rockfish", "Salmon", "Sardines", "Scallops", "Snapper", "Squid", "Striped bass", "Surgeon", "Surimi", "Swordfish", "Tuna", "Yellowfin or ahi", "Yellowtail", "Shellfish", "Crab","Clams", "Crayfish", "Oysters", "Lobster", "Mussels", "Shrimp"])
                break
            case "Meat":
                specificAllergies.append(contentsOf: ["Beef", "Ground", "Rib", "Roast", "Steak", "Variety", "Lamb", "Pork", "Cured", "Chop", "Shoulder", "Leg", "Leg or ham", "Ribs", "Rabbit", "Veal", "Deer or venison", "Chicken", "Duck", "Goose", "Turkey"])
                break
            case "Grain":
                specificAllergies.append(contentsOf: ["Grain", "Rice"])
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
