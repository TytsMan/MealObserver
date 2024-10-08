//
//  MealDetailsView.swift
//  MealObserver
//
//  Created by divan on 9/16/24.
//

import SwiftUI

struct MealDetailsView: View {
    @State private var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            switch viewModel.state {
            case .default:
                Spacer()
            case .loading:
                ProgressView()
            case .error(let message):
                PlaceholderView(
                    imageName: "exclamationmark.triangle.fill",
                    title: message.localized,
                    tintColor: .red
                )
            case .content(let meal):
                mealView(meal)
            }
        }
        .onAppear {
            viewModel.viewDidAppear()
        }
    }
    
    @ViewBuilder 
    private func mealView(_ meal: Meal) -> some View {
        ScrollView {
            VStack(alignment: .center) {
                AsyncImage(url: meal.thumbnailUrl) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 256, height: 256)
                .cornerRadius(32)
                
                if let instructions = meal.instructions {
                    VStack {
                        Text("Instructions:".localized)
                            .font(.headline)
                            .padding()
                        Text(instructions)
                    }.padding()
                }
                
                if let ingredients = meal.ingredients, !ingredients.isEmpty {
                    VStack(alignment: .center) {
                        Text("Ingredients:".localized)
                            .font(.headline)
                            .padding()
                        ForEach(ingredients, id: \.self) { ingredient in
                            HStack {
                                Text("\(ingredient.name.capitalized)")
                                Spacer()
                                Text("\(ingredient.measure)")
                            }
                        }
                    }.padding(.horizontal, 30)
                }
                Spacer()
            }
        }
        .navigationTitle(meal.name)
    }
}

#Preview {
    MealDetailsView(
        viewModel: .init(
            mealId: Meal.mock5.id
        )
    )
}
