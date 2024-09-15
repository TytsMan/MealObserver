//
//  MealFilterService.swift
//  MealObserver
//
//  Created by divan on 9/15/24.
//

import Foundation
import Networking

protocol MealFilterServiceProtocol {
    func filterMeals(query: String, filterType: FilterType) async -> Result<MealFilterResponce, NetworkingError>
}

struct MealFilterService: MealFilterServiceProtocol {
    
    let network: NetworkingClient
    
    func filterMeals(query: String, filterType: FilterType) async -> Result<MealFilterResponce, NetworkingError> {
        let endpoint = FilterMealEndpoint(
            query: query,
            filterType: filterType
        )
        return await network.request(endpoint: endpoint)
    }
}
