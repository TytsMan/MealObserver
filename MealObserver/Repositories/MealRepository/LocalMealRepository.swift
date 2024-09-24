//
//  LocalMealRepository.swift
//  MealObserver
//
//  Created by divan on 9/24/24.
//

import Foundation

actor LocalMealRepository {
    var cachedMeals: [Meal] = []
    var cachedFilters: [String: [Meal]] = [:]
    
    func saveMeal(_ meal: Meal) {
        cachedMeals.append(meal)
    }
    
    func saveFiltered(query: String, meals: [Meal]) {
        cachedFilters[query] = meals
    }
}

// MARK: - MealFilterRepository

extension LocalMealRepository: MealFilterRepository {
    func filterMeals(query: String) async -> Result<[Meal], any Error> {
        .success(cachedFilters[query] ?? [])
    }
}

// MARK: - MealDetailRepository

extension LocalMealRepository: MealDetailRepository {
    func mealDetails(id: Meal.ID) async -> Result<Meal?, any Error> {
        .success(cachedMeals.first(where: { $0.id == id }))
    }
}
