//
//  ScreenFactory.swift
//  MealObserver
//
//  Created by divan on 9/17/24.
//

import Foundation

final class ScreenFactory: ObservableObject {
    private let dependencies: AppDependencies
    
    init(dependencies: AppDependencies) {
        self.dependencies = dependencies
    }
    
    func createMealFilterView() -> MealFilterView {
        MealFilterView(
            viewModel: MealFilterView.ViewModel(
                mealFilterService: MealFilterService(
                    network: dependencies.networkClient
                ),
                state: .default
            )
        )
    }
    
    func createMealDetailsView(mealId: Meal.ID) -> MealDetailsView {
        MealDetailsView(
            viewModel: MealDetailsView.ViewModel(
                mealDetailsService: MealDetailsService(
                    network: dependencies.networkClient
                ),
                mealId: mealId
            )
        )
    }
}
