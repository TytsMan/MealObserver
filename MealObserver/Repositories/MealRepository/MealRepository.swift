//
//  MealRepository.swift
//  MealObserver
//
//  Created by divan on 9/23/24.
//

import Foundation
import Networking

protocol MealFilterRepository {
    func filterMeals(query: String) async -> Result<[Meal], any Error>
}

protocol MealDetailRepository {
    func mealDetails(id: Meal.ID) async -> Result<Meal?, any Error>
}

struct MealRepository {
    let local: LocalMealRepository
    let remote: RemoteMealRepository
}

// MARK: - MealFilterRepository

extension MealRepository: MealFilterRepository {
    func filterMeals(query: String) async -> Result<[Meal], any Error> {
        // Local
        if let meals = await local.filterMeals(query: query).value, !meals.isEmpty {
            return .success(meals)
        }
        // Remote
        let remoteResponse = await remote.filterMeals(query: query)
        if let value = remoteResponse.value {
            await local.saveFiltered(query: query, meals: value)
        }
        return remoteResponse
    }
}

// MARK: - MealDetailRepository

extension MealRepository: MealDetailRepository {
    func mealDetails(id: Meal.ID) async -> Result<Meal?, any Error> {
        // Local
        if let meal = await local.mealDetails(id: id).value ?? nil {
            return .success(meal)
        }
        // Remote
        let remoteResponse = await remote.mealDetails(id: id)
        if let value = remoteResponse.value, let value {
            await local.saveMeal(value)
        }
        return remoteResponse
    }
}
