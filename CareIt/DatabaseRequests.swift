//
//  DatabaseRequests.swift
//  CareIt
//
//  Created by William Londergan (student LM) on 1/16/19.
//  Copyright © 2019 Jason Kozarsky (student LM). All rights reserved.
//

import Foundation

class DatabaseRequests {
    //doesn't work
    var result: String?
    
    init(barcodeString: String, beforeLoading: () -> Void, afterLoading: @escaping () -> Void) {
        beforeLoading()
        let urlString = "https://api.nal.usda.gov/ndb/search/?format=json&q=\(barcodeString)&sort=n&max=25&offset=0&api_key=QeUnhmFwm0AZn3JpYHBwTd1cwx5LMk1zbDwGhgDJ"
        
        guard let url = URL(string: urlString) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, request, error) in
            guard let data = data else {return}
            do{
                
                let res = try JSONDecoder().decode(FoodIDDatabaseRequest.self, from: data)
                
                let ndbno = res.list.item[0].ndbno
                let ndbString = "https://api.nal.usda.gov/ndb/V2/reports?ndbno=\(ndbno)&type=f&format=json&api_key=QeUnhmFwm0AZn3JpYHBwTd1cwx5LMk1zbDwGhgDJ"
                    
                guard let url = URL(string: ndbString) else {return}
                
                //DOUBLE REQUEST BABYYY
                URLSession.shared.dataTask(with: url) {
                    (data, request, error) in
                    guard let data = data else {return}
                    do {
                        let res = try JSONDecoder().decode(NDBDatabaseRequest.self, from: data)
                        
                        self.result = res.foods[0].ing.desc
                       
                    } catch let jsonError {print(jsonError)}
                    
                    DispatchQueue.main.async(execute: afterLoading)
                    
                }.resume()
                
            } catch let jsonError { print(jsonError) }
            
        }.resume()
    }
}
