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
    func mealDetails(id: String) async -> Result<MealDetailsResponce, NetworkingError>
}

struct MealDetailsService: MealDetailsServiceProtocol {
    
    let network: NetworkingClientProtocol
    
    func mealDetails(id: String) async -> Result<MealDetailsResponce, NetworkingError> {
        let endpoint = MealDetailsEndpoint(id: id)
        return await network.request(endpoint: endpoint)
    }
}

#if DEBUG
struct MealDetailsServiceSuccessMock: MealDetailsServiceProtocol {
    func mealDetails(id: String) async -> Result<MealDetailsResponce, NetworkingError> {
        .success(
            MealDetailsResponce(meals: [.mock5])
        )
    }
}
struct MealDetailsServiceFailureMock: MealDetailsServiceProtocol {
    func mealDetails(id: String) async -> Result<MealDetailsResponce, NetworkingError> {
        .failure(
            NetworkingError(statusCode: nil, message: "NetworkingError")
        )
    }
}
#endif
