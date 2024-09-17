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
    
    var body: some Scene {
        WindowGroup {
            screenFactory.createMealFilterView()
                .environmentObject(dependencies)
                .environmentObject(screenFactory)
        }
    }
}
