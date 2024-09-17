//
//  AppDependencies.swift
//  MealObserver
//
//  Created by divan on 9/17/24.
//

import Foundation
import Localizer
import Networking

final class AppDependencies: ObservableObject {
    private(set) lazy var networkClient: NetworkingClient = {
        NetworkingClient(
            config: .init(
                scheme: "https",
                host: "www.themealdb.com",
                header: nil,
                token: "( • )( • ) ԅ(‾⌣‾ԅ)"
            )
        )
    }()
    
    private(set) lazy var localizer = LocalizerClient()
}
