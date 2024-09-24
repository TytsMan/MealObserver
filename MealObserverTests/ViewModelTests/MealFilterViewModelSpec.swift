//
//  MealFilterViewModelSpec.swift
//  MealObserverTests
//
//  Created by divan on 9/17/24.
//

import Quick
import Nimble
import Networking

@testable import MealObserver

final class MealFilterViewModelSpec: AsyncSpec {
    typealias ViewModel = MealFilterView.ViewModel
    typealias State = ViewModel.State
    
    override class func spec() {
        describe("Testing MealFilterViewModel") {
            context("Check initial State") {
                var viewModel: ViewModel!
                beforeEach {
                    viewModel = ViewModel(
                        mealRepository: RemoteMealRepositoryMockSuccess(
                            mockItems: [.mock1, .mock2, .mock3, .mock4, .mock5],
                            mockMeal: .mock5,
                            errorMessage: "Bad request."
                        )
                    )
                }
                
                it("init view model") {
                    expect(viewModel.state)
                        .to(equal(State.default))
                }
            }
            
            context("searchTextDidChanged") {
                var viewModel: ViewModel!
                beforeEach {
                    viewModel = ViewModel(
                        mealRepository: RemoteMealRepositoryMockSuccess(
                            mockItems: [.mock1, .mock2, .mock3, .mock4, .mock5],
                            mockMeal: .mock5,
                            errorMessage: "Bad request."
                        )
                    )
                }
                
                let dummyTexts = ["D", "Des", "Dessert"]
                dummyTexts.forEach { text in
                    it("changeText") {
                        viewModel.searchTextDidChanged(searchText: text)
                        expect(viewModel.state.searchText).to(equal(text))
                    }
                }
            }
            
            context("make a succeful request") {
                let mockItems: [Meal] = [.mock1, .mock2, .mock3, .mock4, .mock5]
                var viewModel: ViewModel!
                beforeEach {
                    viewModel = ViewModel(
                        mealRepository: RemoteMealRepositoryMockSuccess(
                            mockItems: [.mock1, .mock2, .mock3, .mock4, .mock5],
                            mockMeal: .mock5,
                            errorMessage: "Bad request."
                        )
                    )
                }
                
                it("changeText") {
                    viewModel.searchTextDidChanged(searchText: "Dessert")

                    try await Task.sleep(for: .milliseconds(100))
                    expect(viewModel.state.listState)
                        .to(equal(State.ListState.items(mockItems)))
                }
            }
            
            context("make a failure request") {
                let failureMessage: String = "Bad request."
                
                var viewModel: ViewModel!
                beforeEach {
                    viewModel = ViewModel(
                        mealRepository: RemoteMealRepositoryMockFailure(
                            mockItems: [.mock1, .mock2, .mock3, .mock4, .mock5],
                            mockMeal: .mock5,
                            errorMessage: "Bad request."
                        )
                    )
                }
                
                it("changeText") {
                    viewModel.searchTextDidChanged(searchText: "Dessert")

                    let error = NetworkingError(
                        statusCode: nil,
                        message: failureMessage
                    )
                    try await Task.sleep(for: .milliseconds(500))
                    expect(viewModel.state.listState)
                        .to(equal(State.ListState.error(message: error.description)))
                }
            }
        }
    }
}
