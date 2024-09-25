//
//  AppEnvironment.swift
//  MealObserver
//
//  Created by divan on 9/24/24.
//

import Foundation
import Localizer
import Networking

@Observable
final class AppEnvironment {
    let dependencies: Dependencies
    let repositories: Repositories
    let deepLinksHandler: DeepLinksHandler
    
    init(appState: AppState) {
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
        let deepLinksHandler = DeepLinksHandler(appState: appState)
        
        self.dependencies = dependencies
        self.repositories = repositories
        self.deepLinksHandler = deepLinksHandler
    }
}
