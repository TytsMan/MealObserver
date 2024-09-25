//
//  ScreenFactory.swift
//  MealObserver
//
//  Created by divan on 9/17/24.
//

import Foundation

final class ScreenFactory {
    private let env: AppEnvironment
    
    init(env: AppEnvironment) {
        self.env = env
    }
    
    func createMealFilterView() -> MealFilterView {
        MealFilterView(
            viewModel: MealFilterView.ViewModel(
                mealRepository: env.repositories.mealRepository,
                state: .default
            )
        )
    }
    
    func createMealDetailsView(mealId: Meal.ID) -> MealDetailsView {
        MealDetailsView(
            viewModel: MealDetailsView.ViewModel(
                mealRepository: env.repositories.mealRepository,
                mealId: mealId
            )
        )
    }
}
