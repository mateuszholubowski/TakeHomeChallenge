//
//  InsightsView.swift
//  TechChallenge
//
//  Created by Adrian Tineo Cabello on 29/7/21.
//

import SwiftUI

struct InsightsView: View {
    @ObservedObject var viewModel: ViewModel

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        List {
            RingView(viewModel: viewModel)
                .scaledToFit()
            
            ForEach(viewModel.allCategories) { category in
                HStack {
                    Text(category.rawValue)
                        .font(.headline)
                        .foregroundColor(category.color)
                    Spacer()
                    Text(viewModel.categoryAmountText(for: category))
                        .bold()
                        .secondary()
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Insights")
    }
}

#if DEBUG
struct InsightsView_Previews: PreviewProvider {
    static var previews: some View {
        InsightsView(
            viewModel: ViewModel(
                transactions: ModelData.sampleTransactions,
                categories: ModelData.categories
            )
        )
            .previewLayout(.sizeThatFits)
    }
}
#endif
