//
//  RemoteMealRepository.swift
//  MealObserver
//
//  Created by divan on 9/24/24.
//

import Networking

struct RemoteMealRepository {
    private let networkClient: NetworkingClient
    
    init(
        networkClient: NetworkingClient
    ) {
        self.networkClient = networkClient
    }
}

// MARK: - MealFilterRepository

extension RemoteMealRepository: MealFilterRepository {
    func filterMeals(
        query: String
    ) async -> Result<[Meal], any Error> {
        let endpoint = MealFilterEndpoint(
            query: query
        )
        let response = await networkClient.request(endpoint: endpoint)
        return response
            .map { $0.meals?.compactMap { $0 } ?? [] }
            .mapError { $0 }
    }
}

// MARK: - MealDetailRepository

extension RemoteMealRepository: MealDetailRepository {
    func mealDetails(id: Meal.ID) async -> Result<Meal?, any Error> {
        let endpoint = MealDetailsEndpoint(id: id)
        let response = await networkClient.request(endpoint: endpoint)
        return response
            .map { $0.meals?.first ?? nil }
            .mapError { $0 }
    }
}

#if DEBUG

extension RemoteMealRepository {
    static let mockSuccess = RemoteMealRepositoryMockSuccess.mock
    static let mockFailure = RemoteMealRepositoryMockFailure.mock
}
// MARK: - RemoteMealRepositoryMockSuccess

struct RemoteMealRepositoryMockSuccess {
    private let mockItems: [Meal]
    private let mockMeal: Meal
    private let errorMessage: String
    
    init(
        mockItems: [Meal],
        mockMeal: Meal,
        errorMessage: String
    ) {
        self.mockItems = mockItems
        self.mockMeal = mockMeal
        self.errorMessage = errorMessage
    }
    
    static let mock = RemoteMealRepositoryMockSuccess(
        mockItems: [.mock1, .mock2, .mock3, .mock4, .mock5],
        mockMeal: .mock5,
        errorMessage: "Bad request."
    )
}

// MARK: - MealFilterRepository

extension RemoteMealRepositoryMockSuccess: MealFilterRepository {
    func filterMeals(query: String) async -> Result<[Meal], any Error> {
        .success(mockItems.filter({ $0.category == query }))
    }
}

// MARK: - MealDetailRepository

extension RemoteMealRepositoryMockSuccess: MealDetailRepository {
    func mealDetails(id: Meal.ID) async -> Result<Meal?, any Error> {
        guard mockMeal.id == id else {
            return .failure(
                NetworkingError(
                    statusCode: nil,
                    message: errorMessage
                )
            )
        }
        return .success(mockMeal)
    }
}

// MARK: - RemoteMealRepositoryMockFailure

struct RemoteMealRepositoryMockFailure {
    private let mockItems: [Meal]
    private let mockMeal: Meal
    private let errorMessage: String
    
    static let mock = RemoteMealRepositoryMockFailure(
        mockItems: [.mock1, .mock2, .mock3, .mock4, .mock5],
        mockMeal: .mock5,
        errorMessage: "Bad request."
    )
    
    init(
        mockItems: [Meal],
        mockMeal: Meal,
        errorMessage: String
    ) {
        self.mockItems = mockItems
        self.mockMeal = mockMeal
        self.errorMessage = errorMessage
    }
}

// MARK: - MealFilterRepository

extension RemoteMealRepositoryMockFailure: MealFilterRepository {
    func filterMeals(query: String) async -> Result<[Meal], any Error> {
        .failure(
            NetworkingError(
                statusCode: nil,
                message: errorMessage
            )
        )
    }
}

// MARK: - MealDetailRepository

extension RemoteMealRepositoryMockFailure: MealDetailRepository {
    func mealDetails(id: Meal.ID) async -> Result<Meal?, any Error> {
        .failure(
            NetworkingError(
                statusCode: nil,
                message: errorMessage
            )
        )
    }
}

#endif
