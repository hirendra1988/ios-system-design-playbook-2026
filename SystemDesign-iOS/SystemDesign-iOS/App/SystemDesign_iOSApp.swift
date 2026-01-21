//
//  SystemDesign_iOSApp.swift
//  SystemDesign-iOS
//
//  Created by Hirendra Sharma on 20/01/26.
//

import SwiftUI

@main
struct SystemDesign_iOSApp: App {
    
    private let networkContainer = NetworkComposition()
    
    var body: some Scene {
        WindowGroup {
            NetworkLayerView(apiClient: networkContainer.apiClient)
        }
    }
}
