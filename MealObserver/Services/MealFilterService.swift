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
    let network: NetworkingClientProtocol
    
    func filterMeals(query: String, filterType: FilterType) async -> Result<MealFilterResponce, NetworkingError> {
        let endpoint = FilterMealEndpoint(
            query: query,
            filterType: filterType
        )
        return await network.request(endpoint: endpoint)
    }
}

#if DEBUG
struct MealFilterServiceSuccessMock: MealFilterServiceProtocol {
    static let mockItems: [Meal] = [.mock1, .mock2, .mock3, .mock4, .mock5]
    
    func filterMeals(
        query: String,
        filterType: FilterType
    ) async -> Result<MealFilterResponce, Networking.NetworkingError> {
        .success(
            MealFilterResponce(
                meals: Self.mockItems
            )
        )
    }
}
struct MealFilterServiceFailureMock: MealFilterServiceProtocol {
    static let failureMessage = "NetworkingError"
    
    func filterMeals(
        query: String,
        filterType: FilterType
    ) async -> Result<MealFilterResponce, Networking.NetworkingError> {
        .failure(
            NetworkingError(
                statusCode: nil,
                message: Self.failureMessage
            )
        )
    }
}
#endif
