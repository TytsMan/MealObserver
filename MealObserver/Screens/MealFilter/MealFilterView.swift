//
//  MealFilterView.swift
//  MealObserver
//
//  Created by divan on 9/15/24.
//

import Networking
import SwiftUI

struct MealFilterView: View {
    @State private var viewModel: ViewModel
    
    init(viewModel: ViewModel, searchText: String = "") {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                switch viewModel.state.listState {
                case .default:
                    PlaceholderView(
                        imageName: "square.and.pencil",
                        title: "Now you can start searching a meal by category",
                        tintColor: .gray
                    )
                case .loading:
                    ProgressView()
                case .items(let meals):
                    List {
                        ForEach(meals, id: \.self) { meal in
                            NavigationLink {
                                MealDetailsView(viewModel: .init(mealId: meal.id))
                            } label: {
                                MealView(meal: meal)
                            }
                        }
                    }
                case .empty:
                    PlaceholderView(
                        imageName: "swirl.circle.righthalf.filled",
                        title: "You got nothing",
                        tintColor: .gray
                    )
                case .error(let message):
                    PlaceholderView(
                        imageName: "exclamationmark.triangle.fill",
                        title: message,
                        tintColor: .red
                    )
                }
            }
            .navigationTitle("Meal Filter")
        }
        .searchable(text: $viewModel.state.searchText, prompt: "Filter meal by category")
        .onChange(of: viewModel.state.searchText) { _, newValue in
            viewModel.searchTextDidChanged(searchText: newValue)
        }
    }
}

#Preview {
    MealFilterView(
        viewModel: .init(
            state: .init(
                searchText: "",
                listState: .items([.mock1, .mock2, .mock3, .mock4, .mock5].map(Meal.addParagraphsToInstructions))
            )
        )
    )
}
