//
//  NDBDatabaseRequest.swift
//  CareIt
//
//  Created by William Londergan (student LM) on 1/17/19.
//  Copyright © 2019 Jason Kozarsky (student LM). All rights reserved.
//

import Foundation

struct NDBDatabaseRequest: Decodable {
    let foods: [IntermediateFood]
}

struct IntermediateFood: Decodable {
    let food: Food
}

struct Food: Decodable {
    let desc: Description
    let ing: Ingredients
    let nutrients: [Nutrient]
}

struct Description: Decodable {
    let name: String
}

struct Ingredients: Decodable {
    let desc: String
}

struct Nutrient: Decodable {
    let name: String
    let measures: [Measure]
}

struct Measure: Decodable {
    let value: String
    let qty: Int
    let label: String
}




