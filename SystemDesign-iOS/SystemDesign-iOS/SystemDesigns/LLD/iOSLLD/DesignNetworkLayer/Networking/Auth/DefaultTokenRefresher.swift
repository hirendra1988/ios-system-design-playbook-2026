//
//  DefaultTokenRefresher.swift
//  SystemDesign-iOS
//
//  Created by Hirendra Sharma on 21/01/26.
//

import Foundation

final class DefaultTokenRefresher: TokenRefresher {
    func refreshToken() async throws -> String {
        return "new token"
    }
}
