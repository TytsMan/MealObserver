//
//  MealFilterView.swift
//  MealObserver
//
//  Created by divan on 9/15/24.
//

import SwiftUI
import Networking


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
                                Text(meal.title)
                            } label: {
                                MealView(meal: meal)
                            }
                        }
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
            .navigationTitle("My Title")
            
        }
        .searchable(text: $searchText, prompt: "Filter meal by category")
        .onChange(of: searchText) { _, newValue in
            viewModel.searchTextDidChanged(searchText: searchText)
        }
    }
}

#Preview {
    MealFilterView(viewModel: .init())
}
