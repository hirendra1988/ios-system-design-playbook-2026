//
//  NetworkLayerViewModel.swift
//  SystemDesign-iOS
//
//  Created by Hirendra Sharma on 20/01/26.
//

import SwiftUI

class NetworkLayerViewModel: ObservableObject {
    
    let apiClient: APIClient
    @Published var dogList = [String]()
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    @MainActor
    func getDogList() async {
        do {
            let dogs: Dogs = try await apiClient.request(endpoint: APIEndpoints.getDogList)
            print(Array(dogs.message.keys))
            self.dogList = Array(dogs.message.keys)
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
