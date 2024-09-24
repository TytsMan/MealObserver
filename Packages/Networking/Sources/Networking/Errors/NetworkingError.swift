//
//  NetworkingError.swift
//
//
//  Created by divan on 9/15/24.
//

import Foundation

public enum NetworkingError: Error, Equatable {
    
    public static func == (lhs: NetworkingError, rhs: NetworkingError) -> Bool {
        return lhs.code == rhs.code
    }
    
    case internalStatus(status: InternalStatus, message: String? = nil)
    case informational(status: InformationalStatus, message: String?)
    case success(status: SuccessStatus, message: String?)
    case redirection(status: RedirectionStatus, message: String?)
    case clientError(status: ClientErrorStatus, message: String?)
    case serverError(status: ServerErrorStatus, message: String?)
    case nsurlError(status: NSURLError, message: String?)
    
    public init(statusCode: Int?, message: String? = nil) {
        guard let code = statusCode else {
            self = .internalStatus(status: .internetAccessError, message: message)
            return
        }
        
        if let status = InformationalStatus(rawValue: code) {
            self = .informational(status: status, message: message)
            return
        }
        
        if let status = SuccessStatus(rawValue: code) {
            self = .success(status: status, message: message)
            return
        }
        
        if let status = RedirectionStatus(rawValue: code) {
            self = .redirection(status: status, message: message)
            return
        }
        
        if let status = ClientErrorStatus(rawValue: code) {
            self = .clientError(status: status, message: message)
            return
        }
        
        if let status = ServerErrorStatus(rawValue: code) {
            self = .serverError(status: status, message: message)
            return
        }
        
        if let status = NSURLError(rawValue: code) {
            self = .nsurlError(status: status, message: message)
            return
        }
        
        self = .internalStatus(status: .unknown, message: message)
    }
    
    var code: Int {
        switch self {
        case .internalStatus(let status, _):
            return status.code
        case .informational(let status, _):
            return status.code
        case .success(let status, _):
            return status.code
        case .redirection(let status, _):
            return status.code
        case .clientError(let status, _):
            return status.code
        case .serverError(let status, _):
            return status.code
        case .nsurlError(let status, _):
            return status.code
        }
    }
}

extension NetworkingError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .internalStatus(let status, let message):
            return "Internal Status: \(status), \(message ?? "")"
        case .informational(let status, let message):
            return "Informational Status: \(status), \(message ?? "")"
        case .success(let status, let message):
            return "Success Status: \(status), \(message ?? "")"
        case .redirection(let status, let message):
            return "Redirection Status: \(status), \(message ?? "")"
        case .clientError(let status, let message):
            return "Client Error Status: \(status), \(message ?? "")"
        case .serverError(let status, let message):
            return "Server Error Status: \(status), \(message ?? "")"
        case .nsurlError(let status, let message):
            return "NSURLError Status: \(status), \(message ?? "")"
        }
    }
}
extension NetworkingError: LocalizedError {
    public var errorDescription: String? {
        description
    }
}
