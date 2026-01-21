//
//  Token Store.swift
//  SystemDesign-iOS
//
//  Created by Hirendra Sharma on 20/01/26.
//

protocol TokenStore {
    var accessToken: String? { get }
    func save(token: String)
}
