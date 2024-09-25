//
//  AppState.swift
//  MealObserver
//
//  Created by divan on 9/22/24.
//

import Localizer
import Networking
import SwiftUI

@Observable
final class AppState {
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

struct Repositories {
    let mealRepository: MealRepository
}

struct Dependencies {
    let networkClient: NetworkingClient
    let localizer: LocalizerClient
}
