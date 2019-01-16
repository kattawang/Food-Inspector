//
//  DatabaseRequests.swift
//  CareIt
//
//  Created by William Londergan (student LM) on 1/16/19.
//  Copyright © 2019 Jason Kozarsky (student LM). All rights reserved.
//

import Foundation

class DatabaseRequests {
    
    var result: Food?
    
    init(barcodeString: String, beforeLoading: () -> Void, afterLoading: () -> Void) {
        beforeLoading()
        //data request
        afterLoading()
    }
}
