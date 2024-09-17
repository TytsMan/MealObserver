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
            case `default`
            case loading
            case error(message: String)
            case content(Meal)
        }
        
        private let mealDetailsService: MealDetailsServiceProtocol
        private let mealId: Meal.ID
        
        private(set) var state: State
        
        init(
            mealDetailsService: MealDetailsServiceProtocol = MealDetailsServiceSuccessMock(mockMeal: .mock5),
            state: State = .default,
            mealId: Meal.ID
        ) {
            self.mealDetailsService = mealDetailsService
            self.state = state
            self.mealId = mealId
        }
        
        func viewDidAppear() {
            fetchMealDetails(mealId: mealId)
        }
        
        private func fetchMealDetails(mealId: Meal.ID) {
            state = .loading
            Task {
                let result = await mealDetailsService.mealDetails(id: mealId)
                switch result {
                case .success(let responce):
                    guard let meal = responce.meals?.compactMap({ $0 }).first else {
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
