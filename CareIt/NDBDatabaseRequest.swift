//
//  NDBDatabaseRequest.swift
//  CareIt
//
//  Created by William Londergan (student LM) on 1/17/19.
//  Copyright © 2019 Jason Kozarsky (student LM). All rights reserved.
//

import Foundation

struct NDBDatabaseRequest: Decodable {
    let foods: [Food]
}

struct Food: Decodable {
    let name: String
    let ing: Ingredients
}

struct Ingredients: Decodable {
    let desc: String
}
