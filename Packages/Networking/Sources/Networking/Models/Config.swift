//
//  Config.swift
//
//
//  Created by divan on 9/15/24.
//

import Foundation

public struct Config {
    
    let scheme: String
    let host: String
    let header: [String: String]?
    let token: String?
    
    public init(
        scheme: String,
        host: String,
        header: [String : String]?,
        token: String?
    ) {
        self.scheme = scheme
        self.host = host
        self.header = header
        self.token = token
    }
}
