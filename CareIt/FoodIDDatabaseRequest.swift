//
//  Food.swift
//  CareIt
//
//  Created by William Londergan (student LM) on 1/16/19.
//  Copyright © 2019 Jason Kozarsky (student LM). All rights reserved.
//

import Foundation

struct FoodIDDatabaseRequest: Decodable {
    let list: List
}

struct List: Decodable {
    let item: [Item]
}

struct Item: Decodable {
    let ndbno: String
}

