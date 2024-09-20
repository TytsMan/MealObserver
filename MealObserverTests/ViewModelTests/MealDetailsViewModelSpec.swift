//
//  MealDetailsViewModelSpec.swift
//  MealObserverTests
//
//  Created by divan on 9/17/24.
//

import Quick
import Nimble
import Networking

@testable import MealObserver

final class MealDetailsViewModelSpec: AsyncSpec {
    typealias ViewModel = MealDetailsView.ViewModel
    typealias State = ViewModel.State
    
    override class func spec() {
        describe("Testing MealFilterViewModel") {
            let mockMeal: Meal = .mock5
            let errorMessage = "Bad meal id."
            
            context("Check inital state") {
                var viewModel: ViewModel!
                beforeEach {
                    viewModel = ViewModel(
                        mealDetailsService: MealDetailsServiceSuccessMock(
                            mockMeal: mockMeal,
                            errorMessage: errorMessage
                        ),
                        mealId: mockMeal.id
                    )
                }
                
                it("view did appear") {
                    expect(viewModel.state)
                        .to(equal(State.default))
                }
            }
            
            context("make a succeful request") {
                var viewModel: ViewModel!
                beforeEach {
                    viewModel = ViewModel(
                        mealDetailsService: MealDetailsServiceSuccessMock(
                            mockMeal: mockMeal,
                            errorMessage: errorMessage
                        ),
                        mealId: mockMeal.id
                    )
                }
                
                it("view did appear") {
                    viewModel.viewDidAppear()

                    try await Task.sleep(for: .milliseconds(100))
                    let fetchedMeal = Meal.addParagraphsToInstructions(meal: mockMeal)
                    expect(viewModel.state)
                        .to(equal(State.content(fetchedMeal)))
                }
            }
            
            context("make a bad id request") {
                var viewModel: ViewModel!
                beforeEach {
                    viewModel = ViewModel(
                        mealDetailsService: MealDetailsServiceSuccessMock(
                            mockMeal: mockMeal,
                            errorMessage: errorMessage
                        ),
                        mealId: "Bad id"
                    )
                }
                
                it("view did appear") {
                    viewModel.viewDidAppear()

                    try await Task.sleep(for: .milliseconds(100))
                    let error = NetworkingError(
                        statusCode: nil,
                        message: errorMessage
                    )
                    expect(viewModel.state)
                        .to(equal(State.error(message: error.description)))
                }
            }
            
            context("make a failure request") {
                var viewModel: ViewModel!
                beforeEach {
                    viewModel = ViewModel(
                        mealDetailsService: MealDetailsServiceFailureMock(
                            errorMessage: errorMessage
                        ),
                        mealId: mockMeal.id
                    )
                }
                
                it("view did appear") {
                    viewModel.viewDidAppear()

                    try await Task.sleep(for: .milliseconds(100))
                    let error = NetworkingError(
                        statusCode: nil,
                        message: errorMessage
                    )
                    expect(viewModel.state)
                        .to(equal(State.error(message: error.description)))
                }
            }
        }
    }
}
