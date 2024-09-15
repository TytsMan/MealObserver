//
//  MealDetailsEndpoint.swift
//  MealObserver
//
//  Created by divan on 9/15/24.
//

import Foundation
import Networking

struct MealDetailsEndpoint {
    
    private let id: String
    
    init(id: String) {
        self.id = id
    }
    
}

extension MealDetailsEndpoint: Endpoint {
    
    typealias Response = MealDetailsResponce
    
    var path: String {
        "/api/json/v1/1/lookup.php"
    }
    
    var method: Networking.RequestMethod {
        .get
    }
    
    var queryItems: [URLQueryItem]? {
        [.init(name: "i", value: id)]
    }
}
