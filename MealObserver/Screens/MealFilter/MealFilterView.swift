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
    @State private var searchText = ""
    
    init(viewModel: ViewModel, searchText: String = "") {
        self.viewModel = viewModel
        self.searchText = searchText
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                switch viewModel.listState {
                case .default:
                    VStack {
                        Image(systemName: "swirl.circle.righthalf.filled")
                            .frame(width: 36, height: 36)
                            .foregroundColor(.gray)
                        Text("Now you can start searching category")
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }
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
                    VStack {
                        Image(systemName: "swirl.circle.righthalf.filled")
                            .frame(width: 36, height: 36)
                            .foregroundColor(.gray)
                        Text("You got nothing")
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }
                case .error(let message):
                    VStack {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .frame(width: 36, height: 36)
                            .foregroundColor(.red)
                        Text(message)
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }
                }
            }
            .navigationTitle("Meal Filter")
        }
        .searchable(text: $searchText, prompt: "Filter meal by category")
        .onChange(of: searchText) { _, newValue in
            viewModel.searchTextDidChanged(searchText: newValue)
        }
    }
}

#Preview {
    MealFilterView(
        viewModel: .init(listState: .items([.mock1, .mock2, .mock3, .mock4, .mock5]
            .map(Meal.addParagraphsToInstructions)))
    )
}
