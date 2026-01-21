//
//  NetworkSession.swift
//  SystemDesign-iOS
//
//  Created by Hirendra Sharma on 20/01/26.
//

import Foundation

// NetworkSession (Adapter for URLSession)

extension URLSession: NetworkSession {
    func request(_ request: URLRequest) async throws -> (Data, URLResponse) {
        return try await data(for: request)
    }
}
