//
//  MealDetailsService.swift
//  MealObserver
//
//  Created by divan on 9/15/24.
//

import Foundation

import Foundation
import Networking

protocol MealDetailsServiceProtocol {
    func filterMeals(id: String) async -> Result<MealDetailsResponce, NetworkingError>
}

struct MealDetailsService: MealDetailsServiceProtocol {
    
    let network: NetworkingClient
    
    func filterMeals(id: String) async -> Result<MealDetailsResponce, NetworkingError> {
        let endpoint = MealDetailsEndpoint(id: id)
        return await network.request(endpoint: endpoint)
    }
}
