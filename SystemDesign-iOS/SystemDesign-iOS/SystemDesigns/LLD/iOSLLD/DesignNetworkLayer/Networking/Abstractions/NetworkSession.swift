//
//  NetworkSession.swift
//  SystemDesign-iOS
//
//  Created by Hirendra Sharma on 21/01/26.
//

import Foundation

protocol NetworkSession {
    func request(_ request: URLRequest) async throws -> (Data, URLResponse)
}
