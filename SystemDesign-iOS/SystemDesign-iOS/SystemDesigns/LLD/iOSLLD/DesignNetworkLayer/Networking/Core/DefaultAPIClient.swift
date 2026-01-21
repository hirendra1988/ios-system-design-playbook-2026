//
//  DefaultAPIClient.swift
//  SystemDesign-iOS
//
//  Created by Hirendra Sharma on 20/01/26.
//

import Foundation

final class DefaultAPIClient: APIClient {
    
    private var decoder: JSONDecoder
    private var tokenProvider: TokenProvider
    private var session: NetworkSession
    
    init(decoder: JSONDecoder = JSONDecoder(),
         tokenProvider: TokenProvider,
         session: NetworkSession = URLSession.shared) {
        self.decoder = decoder
        self.tokenProvider = tokenProvider
        self.session = session
    }
    
    func request<T>(endpoint: Endpoint) async throws -> T where T : Decodable {
        let request = try buildRequest(endpoint: endpoint)
        let (data, response) = try await session.request(request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.unknow(NSError())
        }

        switch httpResponse.statusCode {
        case 200...299:
            do {
                return try decoder.decode(T.self, from: data)
            } catch {
                throw NetworkError.decodingError
            }
        case 401:
            throw NetworkError.unauthorised
        default:
            throw NetworkError.unknow(NSError())
        }
    }
}

private extension DefaultAPIClient {
    func buildRequest(endpoint: Endpoint) throws -> URLRequest {
        let path = endpoint.baseURL.appending(path: endpoint.path)

        var request = URLRequest(url: path)
        request.httpMethod = endpoint.method.rawValue
        request.httpBody = endpoint.body
        request.allHTTPHeaderFields = endpoint.headers
        
        endpoint.headers?.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        if let accessToken = tokenProvider.accessToken {
            request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        }
        
        return request
    }
}
