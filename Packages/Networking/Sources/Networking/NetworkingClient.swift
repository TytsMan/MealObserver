// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

public class NetworkingClient {
    
    private let config: Config
    
    private var session: URLSession {
        let configuration = URLSessionConfiguration.default
        return URLSession(configuration: configuration)
    }
    
    public var decoder = JSONDecoder()
    
    public init(
        config: Config
    ) {
        self.config = config
    }
    
    public func request<E: Endpoint>(endpoint: E) async -> Result<E.Response, NetworkingError> {
        
        // Creating request
        let createRequestResult = createRequest(from: endpoint)
        if let failure = createRequestResult.failure {
            return .failure(failure)
        }
        
        guard let request = createRequestResult.success else {
            return .failure(.init(statusCode: nil))
        }
        
        // Performing request
        let requestResult = await performRequest(urlRequest: request)
        if let failure = requestResult.failure {
            return .failure(failure)
        }
        
        guard let data = requestResult.success else {
            return .failure(.init(statusCode: nil))
        }
        
        // Decoding
        let decodingResult = decode(data: data, responseType: E.Response.self)
        return decodingResult
    }
    
    private func createRequest(from endpoint: any Endpoint) -> Result<URLRequest, NetworkingError> {
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme ?? config.scheme
        urlComponents.host =  endpoint.host ?? config.host
        urlComponents.path = endpoint.path
        if let queryItems = endpoint.queryItems {
            urlComponents.queryItems = queryItems
        }
        guard let url = urlComponents.url else {
            return .failure(.internalStatus(status: .invalidUrl, message: "Invalid URL"))
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.method.rawValue
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("true", forHTTPHeaderField: "X-Use-Cache")

        if let token = config.token, !token.isEmpty {
            urlRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        if let body = endpoint.body {
            urlRequest.httpBody = body
        }
        
        return .success(urlRequest)
    }
    
    private func performRequest(urlRequest: URLRequest) async -> Result<Data, NetworkingError> {
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                return .failure(NetworkingError(statusCode: nil, message: "Invalid response"))
            }
            
            let networkResponseStatus = NetworkingError(statusCode: httpResponse.statusCode)
            
            switch networkResponseStatus {
            case .success(let status, _):
                if status == .ok {
                    return .success(data)
                } else {
                    return .failure(networkResponseStatus)
                }
            default:
                if let model = try? decoder.decode(NetworkError.self, from: data) {
                    return .failure(NetworkingError(statusCode: httpResponse.statusCode, message: model.error))
                }
                return .failure(networkResponseStatus)
            }
            
        } catch {
            return .failure(.internalStatus(status: .internetAccessError))
        }
    }
    
    private func decode<T: Decodable>(data: Data, responseType: T.Type) -> Result<T, NetworkingError> {
        do {
            let decodedObject = try decoder.decode(responseType, from: data)
            return .success(decodedObject)
        } catch {
            return .failure(.internalStatus(status: .decodingFailed, message: "Decoding failed"))
        }
    }
}
