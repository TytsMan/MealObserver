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
#endif
