//
//  RetryPolicy.swift
//  SystemDesign-iOS
//
//  Created by Hirendra Sharma on 20/01/26.
//

protocol RetryPolicy {
    func shouldRetry(error: Error, attempt: Int) -> Bool
    var maxRetryCount: Int { get }
}

struct DefaultRetryPolicy: RetryPolicy {
    
    var maxRetryCount: Int {
        return 3
    }
    
    func shouldRetry(error: any Error, attempt: Int) -> Bool {
        guard attempt < maxRetryCount else {
            return false
        }
        if let networkError = error as? NetworkError {
            switch networkError {
            case .unauthorised, .noInternet, .serverError(500...599):
                return true
            default:
                return false
            }
        }
        return true
    }
}
