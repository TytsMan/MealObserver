//
//  MealObserverApp.swift
//  MealObserver
//
//  Created by divan on 9/15/24.
//

import SwiftUI

let appState: AppState = AppState()
let environment: AppEnvironment = AppEnvironment(appState: appState)

@main
struct MealObserverApp: App {
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(appState)
                .environment(environment)
                .onOpenURL { incomingURL in
                    handleIncomingURL(incomingURL)
                }
        }
    }
    
    private func handleIncomingURL(_ url: URL) {
        guard let deepLink = Deeplink(url: url) else { return }
        environment.deepLinksHandler.open(deepLink: deepLink)
    }
}
