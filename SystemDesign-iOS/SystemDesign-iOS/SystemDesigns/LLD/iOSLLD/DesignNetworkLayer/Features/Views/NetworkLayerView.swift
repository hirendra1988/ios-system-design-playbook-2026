//
//  NetworkLayer.swift
//  SystemDesign-iOS
//
//  Created by Hirendra Sharma on 20/01/26.
//

import SwiftUI

struct NetworkLayerView: View {

    @StateObject private var viewModel: NetworkLayerViewModel

    init(apiClient: APIClient) {
        _viewModel = StateObject(
            wrappedValue: NetworkLayerViewModel(apiClient: apiClient)
        )
    }

    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 12) {
                ForEach(viewModel.dogList, id: \.self) { dog in
                    Text(dog)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.red.opacity(0.2))
                        .cornerRadius(8)
                }
            }
            .padding()
        }
        .task {
            await viewModel.getDogList()
        }
    }
}

#Preview {
    // NetworkLayerView(apiClient: MockAPIClient())
}
