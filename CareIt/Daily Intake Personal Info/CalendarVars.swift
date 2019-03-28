//
//  CalendarVars.swift
//  CareIt
//
//  Created by Katherine Wang (student LM) on 3/11/19.
//  Copyright © 2019 Jason Kozarsky (student LM). All rights reserved.
//

import Foundation

let date = Date()
let calendar = Calendar.current

var month = calendar.component(.month, from: date)
var year = calendar.component(.year, from: date)
