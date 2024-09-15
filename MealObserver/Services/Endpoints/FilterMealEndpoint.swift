//
//  FilterMealEndpoint.swift
//  MealObserver
//
//  Created by divan on 9/15/24.
//

import Foundation
import Networking

enum FilterType {
    case ingredient
    case category
    case area
}

struct FilterMealEndpoint {
    
    typealias Query = String
    
    private let query: Query
    private let filterType: FilterType
   
    init(query: Query, filterType: FilterType) {
        self.query = query
        self.filterType = filterType
    }
}

extension FilterMealEndpoint: Endpoint {
    
    typealias Response = MealFilterResponce
    
    var path: String {
        "/api/json/v1/1/filter.php"
    }
    
    var method: RequestMethod {
        .get
    }
    
    var queryItems: [URLQueryItem]? {
        [URLQueryItem(name: filterType.queryName, value: query)]
    }
}

private extension FilterType {
    var queryName: String {
        switch self {
        case .ingredient:
            "i"
        case .category:
            "c"
        case .area:
            "a"
        }
    }
}
