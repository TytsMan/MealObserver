//
//  RootView.swift
//  MealObserver
//
//  Created by divan on 9/24/24.
//

import SwiftUI

struct RootView: View {
    @Environment(AppState.self) var appState
    @Environment(AppEnvironment.self) var env

    var body: some View {
        @Bindable var appState = appState
        let screenFactory = ScreenFactory(env: env)
        NavigationStack(path: $appState.navigationPath) {
            screenFactory.createMealFilterView()
                .navigationDestination(for: NavigationDestination.self) { dest in
                    switch dest {
                    case let .details(mealId):
                        screenFactory.createMealDetailsView(mealId: mealId)
                    case .search:
                        screenFactory.createMealFilterView()
                    }
                }
        }
    }
}
