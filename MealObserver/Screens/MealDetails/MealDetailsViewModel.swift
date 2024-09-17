//
//  MealDetailsViewModel.swift
//  MealObserver
//
//  Created by divan on 9/16/24.
//

import Foundation

extension MealDetailsView {
    @Observable
    class ViewModel {
        enum State: Hashable {
            case loading
            case error(message: String)
            case content(Meal)
        }
        
        private var mealDetailsService: MealDetailsServiceProtocol
        
        var state: State
        
        init(
            mealDetailsService: MealDetailsServiceProtocol = MealDetailsServiceSuccessMock(),
            mealId: Meal.ID
        ) {
            self.state = .loading
            self.mealDetailsService = mealDetailsService
            fetchMealDetails(mealId: mealId)
        }
        
        private func fetchMealDetails(mealId: Meal.ID) {
            Task {
                let result = await mealDetailsService.mealDetails(id: mealId)
                switch result {
                case .success(let responce):
                    guard let meal = responce.meals?.first else {
                        state = .error(message: "Bad meal id")
                        return
                    }
                    state = .content(Meal.addParagraphsToInstructions(meal: meal))
                case .failure(let error):
                    state = .error(message: error.description)
                }
            }
        }
    }
}
