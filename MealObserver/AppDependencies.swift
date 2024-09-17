//
//  AppDependencies.swift
//  MealObserver
//
//  Created by divan on 9/17/24.
//

import Networking

final class AppDependencies {
    lazy var networkClient: NetworkingClient = {
        NetworkingClient(
            config: .init(
                scheme: "https",
                host: "www.themealdb.com",
                header: nil,
                token: "( • )( • ) ԅ(‾⌣‾ԅ)"
            )
        )
    }()
}
