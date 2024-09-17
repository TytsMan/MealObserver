//
//  MealObserverApp.swift
//  MealObserver
//
//  Created by divan on 9/15/24.
//

import SwiftUI

@main
struct MealObserverApp: App {
    static let dependencies = AppDependencies()
    static let screenFactory = ScreenFactory(dependencies: dependencies)
    
    var body: some Scene {
        WindowGroup {
            Self.screenFactory.createMealFilterView()
                .environmentObject(Self.screenFactory)
        }
    }
}
