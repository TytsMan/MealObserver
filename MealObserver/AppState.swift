//
//  AppState.swift
//  MealObserver
//
//  Created by divan on 9/22/24.
//

import SwiftUI

@Observable
class AppState {
    var navigationPath: NavigationPath = .init()
    
    func navigate(to destination: NavigationDestination) {
        if destination == .search {
            navigationPath = .init()
        } else {
            navigationPath.append(destination)
        }
    }
}

enum NavigationDestination: Hashable {
    case search
    case details(id: Meal.ID)
}
