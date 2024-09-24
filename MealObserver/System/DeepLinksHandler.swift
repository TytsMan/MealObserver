//
//  DeepLinksHandler.swift
//  MealObserver
//
//  Created by divan on 9/24/24.
//

import Foundation

struct Deeplink {
    let page: String
    let parameters: [String: String]
}

protocol DeepLinksHandlerProtocol {
    func open(deepLink: Deeplink)
}

struct DeepLinksHandler: DeepLinksHandlerProtocol {    
    func open(deepLink: Deeplink) {
        switch deepLink.page {
        case NavigationDestination.search.deepLinkName:
            openSearch()
            
        case NavigationDestination.details(id: "").deepLinkName:
            guard let mealId = deepLink.parameters["id"] else { return }
            openDetails(mealId: mealId)
            
        default:
            break
        }
    }
    
    private func openSearch() {
        appState.navigate(to: .search)
    }
    
    private func openDetails(mealId: String) {
        appState.navigate(to: .details(id: mealId))
    }
}

private extension NavigationDestination {
    var deepLinkName: String {
        switch self {
        case .search:
            "search"
        case .details:
            "details"
        }
    }
}
