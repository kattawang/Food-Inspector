//
//  Food.swift
//  CareIt
//
//  Created by William Londergan (student LM) on 1/16/19.
//  Copyright © 2019 Jason Kozarsky (student LM). All rights reserved.
//

import Foundation

struct DecodeToList: Decodable {
    var list: List
}

struct List: Decodable {
    var ds: String
    var end: Int
    var group: String
    var item: Item
    var q: String
    var sort: String
    var sr: Int
    var start: Int
    var total: Int
}

struct Item: Decodable {
    var ds: String
    var group: String
    var manu: String
    var ndbno: String
    var offset: Int
}
