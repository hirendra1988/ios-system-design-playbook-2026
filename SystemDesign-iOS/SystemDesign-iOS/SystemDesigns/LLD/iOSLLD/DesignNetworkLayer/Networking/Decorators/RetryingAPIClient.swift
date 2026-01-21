//
//  RetryingAPIClient.swift
//  SystemDesign-iOS
//
//  Created by Hirendra Sharma on 20/01/26.
//

import Foundation

//RetryingAPIClient (Decorator – Extension Layer)

final class RetryingAPIClient: APIClient {
    
    private let wrapped: APIClient
    private var retryPolicy: RetryPolicy
    private var tokenRefresher: TokenRefresher?
    private var tokenStore: TokenStore?
    
    init(wrapped: APIClient,
         retryPolicy: RetryPolicy,
         tokenRefresher: TokenRefresher? = nil,
         tokenStore: TokenStore? = nil) {
        self.wrapped = wrapped
        self.retryPolicy = retryPolicy
        self.tokenRefresher = tokenRefresher
        self.tokenStore = tokenStore
    }
    
    func request<T>(endpoint: Endpoint) async throws -> T where T : Decodable {
        return try await execute(endpoint: endpoint, attempt: 0)
    }
    
    private func execute<T: Decodable>(endpoint: Endpoint, attempt: Int) async throws -> T {
        do {
            return try await wrapped.request(endpoint: endpoint)
        } catch {
            // 🔐 Token refresh flow
            if let networkError = error as? NetworkError,
               case .unauthorised = networkError,
               let tokenRefresher = tokenRefresher,
               let tokenStore = tokenStore {
                
                let newToken = try await tokenRefresher.refreshToken()
                tokenStore.save(token: newToken)
                return try await wrapped.request(endpoint: endpoint)
            }
            
            // 🔁 Retry logic
            guard retryPolicy.shouldRetry(error: error, attempt: attempt) else {
                throw error
            }
            return try await execute(endpoint: endpoint, attempt: attempt + 1)
        }
    }
}
