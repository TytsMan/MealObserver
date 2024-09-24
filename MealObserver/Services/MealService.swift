//
//  MealService.swift
//  MealObserver
//
//  Created by divan on 9/15/24.
//

import Foundation
import Networking

protocol MealFilterServiceProtocol {
    func filterMeals(query: String, filterType: FilterType) async -> Result<MealFilterResponce, NetworkingError>
}

protocol MealDetailsServiceProtocol {
    func mealDetails(id: String) async -> Result<MealDetailsResponce, NetworkingError>
}

struct MealService: MealFilterServiceProtocol, MealDetailsServiceProtocol {
    private let network: NetworkingClient
    
    init(
        network: NetworkingClient
    ) {
        self.network = network
    }
    
    func filterMeals(query: String, filterType: FilterType) async -> Result<MealFilterResponce, NetworkingError> {
        let endpoint = MealFilterEndpoint(
            query: query,
            filterType: filterType
        )
        return await network.request(endpoint: endpoint)
    }
    
    func mealDetails(id: String) async -> Result<MealDetailsResponce, NetworkingError> {
        let endpoint = MealDetailsEndpoint(id: id)
        return await network.request(endpoint: endpoint)
    }
}

#if DEBUG
struct MealFilterServiceSuccessMock: MealFilterServiceProtocol {
    let mockItems: [Meal]
    
    init(
        mockItems: [Meal] = [.mock1, .mock2, .mock3, .mock4, .mock5]
    ) {
        self.mockItems = mockItems
    }
    
    func filterMeals(
        query: String,
        filterType: FilterType
    ) async -> Result<MealFilterResponce, Networking.NetworkingError> {
        .success(
            MealFilterResponce(
                meals: mockItems
            )
        )
    }
}
struct MealFilterServiceFailureMock: MealFilterServiceProtocol {
    let failureMessage: String
    
    init(failureMessage: String = "Bad request.") {
        self.failureMessage = failureMessage
    }
    
    func filterMeals(
        query: String,
        filterType: FilterType
    ) async -> Result<MealFilterResponce, Networking.NetworkingError> {
        .failure(
            NetworkingError(
                statusCode: nil,
                message: failureMessage
            )
        )
    }
}
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
