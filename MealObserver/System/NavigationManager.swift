//
//  NavigationManager.swift
//  MealObserver
//
//  Created by divan on 9/24/24.
//

import SwiftUI

protocol NavigationManagerProtocol {
    func navigate(to destination: NavigationDestination)
}

final class NavigationManager: NavigationManagerProtocol {
    var navigationPath: NavigationPath
    
    init(
        navigationPath: NavigationPath
    ) {
        self.navigationPath = navigationPath
    }
    
    func navigate(to destination: NavigationDestination) {
        if destination == .search {
            navigationPath = .init()
        } else {
            navigationPath.append(destination)
        }
    }
}
