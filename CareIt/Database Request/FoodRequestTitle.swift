//
//  ProcessTitle.swift
//  CareIt
//
//  Created by William Londergan (student LM) on 2/22/19.
//  Copyright © 2019 Jason Kozarsky (student LM). All rights reserved.
//

import UIKit

func process(_ title: String) -> String {
    //remove all UPC: stuff
    let separated = title.split(separator: " ")
    let filtered = separated.filter {arg in
        return Int64(arg) != nil && arg != "UPC:"
    }
    return filtered.joined(separator: " ")
}


