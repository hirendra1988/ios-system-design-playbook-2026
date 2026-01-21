//
//  NetworkComposition.swift
//  SystemDesign-iOS
//
//  Created by Hirendra Sharma on 20/01/26.
//

final class NetworkComposition {
    // MARK: - Public API
    let apiClient: APIClient
    
    init() {
        // Shared auth state
        let tokenStore = InMemoryTokenStore()
        let tokenRefresher = DefaultTokenRefresher()
        
        // Retry behaviour
        let returnPolicy = DefaultRetryPolicy()
        
        // Core networking
        let baseClient = DefaultAPIClient(tokenProvider: tokenStore)

        // Decorated client (Retry + Auth)
        self.apiClient = RetryingAPIClient(wrapped: baseClient,
                                           returnPolicy: returnPolicy,
                                           tokenRefresher: tokenRefresher,
                                           tokenStore: tokenStore)
        
    }
}
