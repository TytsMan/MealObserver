//
//  DependencyInjectionContainer.swift
//  MealObserver
//
//  Created by divan on 9/15/24.
//

import Foundation

class DependencyInjectionContainer {
    static let shared = DependencyInjectionContainer()

    private var services: [String: Any] = [:]

    func register<T>(_ service: T) {
        services[String(describing: T.self)] = service
    }

    func resolve<T>(_ serviceType: T.Type) -> T? {
        return services[String(describing: T.self)] as? T
    }
}
