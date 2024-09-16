//
//  NetworkingClientProtocol.swift
//  MealObserver
//
//  Created by divan on 9/15/24.
//

import Foundation
import Networking

protocol NetworkingClientProtocol {
    // TODO: Replace `Endpoint` with `URLRequest`
    func request<E: Endpoint>(endpoint: E) async -> Result<E.Response, NetworkingError>
}

extension NetworkingClient: NetworkingClientProtocol { }
