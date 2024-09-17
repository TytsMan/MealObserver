//
//  MealDetailsService.swift
//  MealObserver
//
//  Created by divan on 9/15/24.
//

import Foundation
import Networking

protocol MealDetailsServiceProtocol {
    func mealDetails(id: String) async -> Result<MealDetailsResponce, NetworkingError>
}

struct MealDetailsService: MealDetailsServiceProtocol {
    let network: NetworkingClient
    
    func mealDetails(id: String) async -> Result<MealDetailsResponce, NetworkingError> {
        let endpoint = MealDetailsEndpoint(id: id)
        return await network.request(endpoint: endpoint)
    }
}

#if DEBUG
struct MealDetailsServiceSuccessMock: MealDetailsServiceProtocol {
    let mockMeal: Meal
    let errorMessage: String
    
    init(
        mockMeal: Meal = .mock5,
        errorMessage: String = "Bad meal id."
    ) {
        self.mockMeal = mockMeal
        self.errorMessage = errorMessage
    }
    
    func mealDetails(id: String) async -> Result<MealDetailsResponce, NetworkingError> {
        guard mockMeal.id == id else {
            return .failure(
                NetworkingError(
                    statusCode: nil,
                    message: errorMessage
                )
            )
        }
        return .success(
            MealDetailsResponce(meals: [mockMeal])
        )
    }
}
struct MealDetailsServiceFailureMock: MealDetailsServiceProtocol {
    let errorMessage: String
    
    init(
        errorMessage: String = "Bad meal id."
    ) {
        self.errorMessage = errorMessage
    }
    
    func mealDetails(id: String) async -> Result<MealDetailsResponce, NetworkingError> {
        .failure(
            NetworkingError(
                statusCode: nil,
                message: errorMessage
            )
        )
    }
}
#endif
