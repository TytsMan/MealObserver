//
//  MealView.swift
//  MealObserver
//
//  Created by divan on 9/15/24.
//

import SwiftUI

struct MealView: View {
    var meal: Meal
    
    var body: some View {
        HStack {
            AsyncImage(url: meal.thumbnailUrl) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 64, height: 64)
            .cornerRadius(8)
            
            Text(meal.name)
                .font(.headline)
            
            Spacer()
        }
    }
}

#Preview {
    VStack {
        MealView(meal: .mock1)
        MealView(meal: .mock2)
        MealView(meal: .mock3)
        MealView(meal: .mock4)
    }
}
