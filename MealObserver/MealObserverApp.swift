//
//  MealObserverApp.swift
//  MealObserver
//
//  Created by divan on 9/15/24.
//

import Networking
import SwiftUI

@main
struct MealObserverApp: App {
    let networkClient: NetworkingClient = NetworkingClient(
        config: .init(
            scheme: "https",
            host: "www.themealdb.com",
            header: nil,
            token: nil
        )
    )
    
    var body: some Scene {
        WindowGroup {
            MealFilterView(viewModel: .init(mealFilterService: MealFilterService(network: networkClient)))
        }
    }
}
