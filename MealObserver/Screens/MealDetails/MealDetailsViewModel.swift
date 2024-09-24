//
//  MealDetailsViewModel.swift
//  MealObserver
//
//  Created by divan on 9/16/24.
//

import Foundation
import Networking

extension MealDetailsView {
    @Observable
    class ViewModel {
        enum State: Hashable {
            case `default`
            case loading
            case error(message: String)
            case content(Meal)
        }
        
        private let mealRepository: MealDetailRepository
        private let mealId: Meal.ID
        
        private(set) var state: State
        
        init(
            mealRepository: MealDetailRepository = RemoteMealRepository.mock,
            state: State = .default,
            mealId: Meal.ID
        ) {
            self.mealRepository = mealRepository
            self.state = state
            self.mealId = mealId
        }
        
        func viewDidAppear() {
            fetchMealDetails(mealId: mealId)
        }
        
        private func fetchMealDetails(mealId: Meal.ID) {
            state = .loading
            Task(priority: .background) { [weak self] in
                guard let self else { return }
                let result = await mealRepository.mealDetails(id: mealId)
                Task { @MainActor [weak self] in
                    guard let self else { return }
                    switch result {
                    case .success(let meal):
                        guard let meal else {
                            state = .error(message: "Bad meal id")
                            return
                        }
                        state = .content(Meal.addParagraphsToInstructions(meal: meal))
                    case .failure(let error):
                        state = .error(message: error.localizedDescription)
                    }
                } 
            }
        }
    }
}
