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
    
    init(
        page: String,
        parameters: [String: String]
    ) {
        self.page = page
        self.parameters = parameters
    }
    
    init?(url: URL) {
        guard url.scheme == "mealapp" else {
            return nil
        }
        
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            // TODO: Log error
            print("Invalid URL")
            return nil
        }
        
        guard let page = components.host else {
            // TODO: Log error
            print("Unknown URL, we can't handle this one!")
            return nil
        }
        
        let parameters = components.queryItems?.reduce(into: [String: String](), { partialResult, item in
            guard let value = item.value else { return () }
            partialResult[item.name] = value
        }) ?? [:]
        
        self = .init(page: page, parameters: parameters)
    }
}

protocol DeepLinksHandlerProtocol {
    func open(deepLink: Deeplink)
}

struct DeepLinksHandler: DeepLinksHandlerProtocol {
    private let appState: AppState
    
    init(appState: AppState) {
        self.appState = appState
    }
    
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
