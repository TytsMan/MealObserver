//
//  MealFilterViewModelSpec.swift
//  MealObserverTests
//
//  Created by divan on 9/17/24.
//

import Foundation
import Quick
import Nimble
import Networking

@testable import MealObserver

final class MealFilterViewModelSpec: AsyncSpec {
    override class func spec() {
        describe("Testing MealFilterViewModel") {
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
                var viewModel: MealFilterView.ViewModel!
                beforeEach {
                    viewModel = MealFilterView.ViewModel(
                        mealFilterService: MealFilterServiceSuccessMock()
                    )
                }
                
                it("changeText") {
                    expect(viewModel.state.listState)
                        .to(equal(MealFilterView.ViewModel.State.ListState.default))

                    viewModel.searchTextDidChanged(searchText: "Dessert")

                    try await Task.sleep(for: .milliseconds(500))
                    expect(viewModel.state.listState)
                        .to(equal(MealFilterView.ViewModel.State.ListState.items(MealFilterServiceSuccessMock.mockItems)))
                }
            }
            
            context("make a failure request") {
                var viewModel: MealFilterView.ViewModel!
                beforeEach {
                    viewModel = MealFilterView.ViewModel(
                        mealFilterService: MealFilterServiceFailureMock()
                    )
                }
                
                it("changeText") {
                    expect(viewModel.state.listState)
                        .to(equal(MealFilterView.ViewModel.State.ListState.default))

                    viewModel.searchTextDidChanged(searchText: "Dessert")

                    let failureMessage = NetworkingError(
                        statusCode: nil,
                        message: MealFilterServiceFailureMock.failureMessage
                    ).description
                    try await Task.sleep(for: .milliseconds(500))
                    expect(viewModel.state.listState)
                        .to(equal(MealFilterView.ViewModel.State.ListState.error(message: failureMessage)))
                }
            }
        }
    }
}
