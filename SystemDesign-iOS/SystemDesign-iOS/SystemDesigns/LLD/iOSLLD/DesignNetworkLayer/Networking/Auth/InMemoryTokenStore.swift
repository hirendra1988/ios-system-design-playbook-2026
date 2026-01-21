//
//  InMemoryTokenStore.swift
//  SystemDesign-iOS
//
//  Created by Hirendra Sharma on 21/01/26.
//

import Foundation

final class InMemoryTokenStore: TokenStore, TokenProvider {
    private(set) var accessToken: String?

    func save(token: String) {
        self.accessToken = token
    }
}
