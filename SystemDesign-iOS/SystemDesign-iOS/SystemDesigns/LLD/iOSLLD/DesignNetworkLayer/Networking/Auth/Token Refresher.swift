//
//  Token Refresher.swift
//  SystemDesign-iOS
//
//  Created by Hirendra Sharma on 20/01/26.
//

import Foundation

protocol TokenRefresher {
    func refreshToken() async throws -> String
}
