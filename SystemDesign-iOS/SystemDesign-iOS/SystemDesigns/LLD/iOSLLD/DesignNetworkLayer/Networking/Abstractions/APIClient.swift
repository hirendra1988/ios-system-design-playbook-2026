//
//  APIClient.swift
//  SystemDesign-iOS
//
//  Created by Hirendra Sharma on 20/01/26.
//

import Foundation

protocol APIClient {
    func request<T: Decodable>(endpoint: Endpoint) async throws -> T
}
