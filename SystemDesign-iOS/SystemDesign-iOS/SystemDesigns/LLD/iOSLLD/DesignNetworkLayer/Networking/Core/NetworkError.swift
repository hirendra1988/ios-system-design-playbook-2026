//
//  NetworkError.swift
//  SystemDesign-iOS
//
//  Created by Hirendra Sharma on 20/01/26.
//

enum NetworkError: Error {
    case invalidURL
    case serverError(Int)
    case decodingError
    case noInternet
    case unauthorised
    case unknow(Error)
}
