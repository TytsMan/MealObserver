//
//  Endpoint.swift
//
//
//  Created by divan on 9/15/24.
//

import Foundation

public protocol Endpoint {
    
    associatedtype Response: Decodable
    
    var scheme: String? { get }
    var host: String? { get }
    var path: String { get }
    var method: RequestMethod { get }
    var queryItems: [URLQueryItem]? { get }
    var header: [String: String]? { get }
    var body: Data? { get }
}

public extension Endpoint {
    
    var scheme: String? { nil }
    
    var host: String? { nil }
    
    var queryItems: [URLQueryItem]? { nil }
    
    var header: [String: String]? { nil }
    
    var body: Data? { nil }
}
