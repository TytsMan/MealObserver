//
//  MealObserverApp.swift
//  MealObserver
//
//  Created by divan on 9/15/24.
//

import Localizer
import Networking
import SwiftUI

let dependencies = Dependencies(
    networkClient: NetworkingClient(
        config: .init(
            scheme: "https",
            host: "www.themealdb.com",
            header: nil,
            token: "( • )( • ) ԅ(‾⌣‾ԅ)"
        )
    ),
    localizer: LocalizerClient()
)

let repositories = Repositories(
    mealRepository: .init(
        local: .init(),
        remote: .init(networkClient: dependencies.networkClient)
    )
)

let appState: AppState = .init(
    navigationPath: NavigationPath(),
    repositories: repositories,
    dependencies: dependencies
)

@main
struct MealObserverApp: App {
    private let screenFactory = ScreenFactory(appState: appState)
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(appState)
                .environmentObject(screenFactory)
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
