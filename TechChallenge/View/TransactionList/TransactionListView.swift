//
//  TransactionListView.swift
//  TechChallenge
//
//  Created by Adrian Tineo Cabello on 27/7/21.
//

import SwiftUI

struct TransactionListView: View {
    @ObservedObject var viewModel: ViewModel

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack {
            ScrollView(.horizontal) {
                LazyHStack {
                    ForEach(viewModel.filterCategories) { category in
                        Button(
                            action: {
                                viewModel.onCategoryFilterSelected(categoryFilter: category)
                            }
                        ) {
                        Text(category.name)
                            .font(.system(.title2))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(8)
                        }
                        .background(category.color)
                        .clipShape(RoundedRectangle(cornerRadius: 20.0))
                    }
                }
                .frame(height: 50)
                .padding(16.0)
            }
            .background(Color.accentColor.opacity(0.8))

            List {
                ForEach(viewModel.filteredTransactions) { transaction in
                    Button(action: {
                        viewModel.onTransactionSelected(transaction: transaction)
                    }) {
                        TransactionView(transactionViewModel: transaction)
                    }
                }
            }
            .animation(.easeIn)
            .listStyle(PlainListStyle())
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Transactions")

            HStack {
                VStack {
                    Spacer()
                    Text("Total spent:")
                        .secondary()
                        .foregroundColor(.black)
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text(viewModel.currentCategoryFilterSelected.name)
                        .foregroundColor(viewModel.currentCategoryFilterSelected.color)
                        .secondary()
                    Text(viewModel.summaryAmountText)
                        .fontWeight(.bold)
                        .secondary()
                }
            }
            .padding(20)
            .overlay(
                RoundedRectangle(cornerRadius: 8.0)
                        .strokeBorder(Color.black, lineWidth: 2)
            )
            .frame(height: 80)
        }
    }
}

#if DEBUG
struct TransactionListView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionListView(
            viewModel: ViewModel(
                transactions: ModelData.sampleTransactions,
                categories: ModelData.categories
            )
        )
    }
}
#endif
