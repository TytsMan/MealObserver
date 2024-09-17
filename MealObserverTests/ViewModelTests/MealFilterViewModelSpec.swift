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
    override class func spec() {
        describe("Testing MealFilterViewModel") {
            context("Check initial State") {
                var viewModel: MealFilterView.ViewModel!
                beforeEach {
                    viewModel = MealFilterView.ViewModel(
                        mealFilterService: MealFilterServiceSuccessMock()
                    )
                }
                
                it("init view model") {
                    expect(viewModel.state)
                        .to(equal(MealFilterView.ViewModel.State.default))
                }
            }
            
            context("searchTextDidChanged") {
                var viewModel: MealFilterView.ViewModel!
                beforeEach {
                    viewModel = MealFilterView.ViewModel(
                        mealFilterService: MealFilterServiceSuccessMock()
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
                var viewModel: MealFilterView.ViewModel!
                beforeEach {
                    viewModel = MealFilterView.ViewModel(
                        mealFilterService: MealFilterServiceSuccessMock(
                            mockItems: mockItems
                        )
                    )
                }
                
                it("changeText") {
                    expect(viewModel.state.listState)
                        .to(equal(MealFilterView.ViewModel.State.ListState.default))

                    viewModel.searchTextDidChanged(searchText: "Dessert")

                    try await Task.sleep(for: .milliseconds(500))
                    expect(viewModel.state.listState)
                        .to(equal(MealFilterView.ViewModel.State.ListState.items(mockItems)))
                }
            }
            
            context("make a failure request") {
                let failureMessage: String = "Bad request."
                
                var viewModel: MealFilterView.ViewModel!
                beforeEach {
                    viewModel = MealFilterView.ViewModel(
                        mealFilterService: MealFilterServiceFailureMock(failureMessage: failureMessage)
                    )
                }
                
                it("changeText") {
                    expect(viewModel.state.listState)
                        .to(equal(MealFilterView.ViewModel.State.ListState.default))

                    viewModel.searchTextDidChanged(searchText: "Dessert")

                    let error = NetworkingError(
                        statusCode: nil,
                        message: failureMessage
                    )
                    try await Task.sleep(for: .milliseconds(500))
                    expect(viewModel.state.listState)
                        .to(equal(MealFilterView.ViewModel.State.ListState.error(message: error.description)))
                }
            }
        }
    }
}
