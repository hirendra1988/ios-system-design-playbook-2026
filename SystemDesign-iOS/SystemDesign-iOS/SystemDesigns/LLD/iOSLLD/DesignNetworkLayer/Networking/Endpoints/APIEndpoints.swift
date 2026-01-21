//
//  APIEndPoints.swift
//  SystemDesign-iOS
//
//  Created by Hirendra Sharma on 20/01/26.
//

import Foundation

protocol Endpoint {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var queryItems: [URLQueryItem]? { get }
    var body: Data? { get }
}

enum APIEndpoints: Endpoint {

    case user
    case profile
    case getDogList
    
    var baseURL: URL {
        return URL(string: "https://dog.ceo/api/")!
    }
    
    var path: String {
        switch self {
        case .user:
            return "user"
        case .profile:
            return "profile"
        case .getDogList:
            return "breeds/list/all"
        }
    }
    
    var method: HTTPMethod {
        return .GET
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
    var queryItems: [URLQueryItem]? {
        return nil
    }
    
    var body: Data? {
        return nil
    }
    
}
