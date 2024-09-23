//
//  MealObserverApp.swift
//  MealObserver
//
//  Created by divan on 9/15/24.
//

import SwiftUI

let dependencies = AppDependencies()

@main
struct MealObserverApp: App {
    private let screenFactory = ScreenFactory(dependencies: dependencies)
    
    var appState: AppState = .init()
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(dependencies)
                .environmentObject(screenFactory)
                .environment(appState)
        }
    }
}

struct RootView: View {
    @EnvironmentObject var screenFactory: ScreenFactory
    @Environment(AppState.self) var appState
    
    var body: some View {
        @Bindable var appState = appState
        NavigationStack(path: $appState.navigationPath) {
            screenFactory.createMealFilterView()
                .navigationDestination(for: NavigationDestination.self) { dest in
                    switch dest {
                    case let .details(mealId):
                        screenFactory.createMealDetailsView(mealId: mealId)
                    default:
                        Text("Destination is not reachable!")
                    }
                }
        }
    }
}
