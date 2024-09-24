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

let deepLinksHandler = DeepLinksHandler()

let appState = AppState(
    repositories: repositories,
    dependencies: dependencies,
    deepLinksHandler: deepLinksHandler
)

@main
struct MealObserverApp: App {
    private let screenFactory = ScreenFactory(appState: appState)
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(appState)
                .environmentObject(screenFactory)
                .onOpenURL { incomingURL in
                    handleIncomingURL(incomingURL)
                }
        }
    }
    
    private func handleIncomingURL(_ url: URL) {
        guard url.scheme == "mealapp" else {
            return
        }
        
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            // TODO: Log error
            print("Invalid URL")
            return
        }
        
        guard let page = components.host else {
            // TODO: Log error
            print("Unknown URL, we can't handle this one!")
            return
        }
        
        let parameters = components.queryItems?.reduce(into: [String: String](), { partialResult, item in
            guard let value = item.value else { return () }
            partialResult[item.name] = value
        }) ?? [:]
        
        let deepLink = Deeplink(
            page: page,
            parameters: parameters
        )
        appState.deepLinksHandler.open(deepLink: deepLink)
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
