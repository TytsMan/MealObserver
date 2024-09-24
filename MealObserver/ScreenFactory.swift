//
//  ScreenFactory.swift
//  MealObserver
//
//  Created by divan on 9/17/24.
//

import Foundation

final class ScreenFactory: ObservableObject {
    private let appState: AppState
    
    init(appState: AppState) {
        self.appState = appState
    }
    
    func createMealFilterView() -> MealFilterView {
        MealFilterView(
            viewModel: MealFilterView.ViewModel(
                mealRepository: appState.repositories.mealRepository,
                state: .default
            )
        )
    }
    
    func createMealDetailsView(mealId: Meal.ID) -> MealDetailsView {
        MealDetailsView(
            viewModel: MealDetailsView.ViewModel(
                mealRepository: appState.repositories.mealRepository,
                mealId: mealId
            )
        )
    }
}
