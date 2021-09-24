//
//  TransactionListViewModel.swift
//  TechChallenge
//
//  Created by mholubowski on 24/09/2021.
//

import Foundation

class ViewModel: ObservableObject {
    let allCategories = TransactionModel.Category.allCases

    let allTransactions: [TransactionListItemViewModel]

    @Published var filterCategories: [CategoryModel]

    var currentCategoryFilterSelected: CategoryModel = .all {
        didSet {
            updateTransactionsList(with: currentCategoryFilterSelected)
        }
    }

    @Published var filteredTransactions: [TransactionListItemViewModel] {
        didSet {
            updateSummaryAmountText(with: filteredTransactions)
        }
    }

    @Published var summaryAmountText: String = ""

    public init (
        transactions: [TransactionModel],
        categories: [TransactionModel.Category]
    ) {
        allTransactions = transactions.map(TransactionListItemViewModel.init)
        filterCategories = [.all] + categories.map(CategoryModel.category)
        filteredTransactions = allTransactions
        updateTransactionsList(with: currentCategoryFilterSelected)
    }

    func onCategoryFilterSelected(categoryFilter: CategoryModel) {
        currentCategoryFilterSelected = categoryFilter
    }

    func onTransactionSelected(transaction: TransactionListItemViewModel) {
        transaction.isPinned.toggle()
        updateSummaryAmountText(with: filteredTransactions)
    }
}

// Insights

extension ViewModel {
    func ratio(for categoryIndex: Int) -> Double {
        guard let category = TransactionModel.Category[categoryIndex] else {
            assertionFailure()
            return 0
        }
        let summaryAmount = allTransactions.filter { $0.isPinned }.reduce(0) { $0 + $1.model.amount }
        guard summaryAmount > 0 else { return 0 }
        let pinnedAmount = categoryAmount(for: category)

        return pinnedAmount / summaryAmount
    }

    func categoryAmountText(for category: TransactionModel.Category) -> String {
        let amount = categoryAmount(for: category)
        return AmountFormatter.format(amount: amount)
    }

    private func categoryAmount(for category: TransactionModel.Category) -> Double {
        return allTransactions
            .filter { $0.isPinned &&  $0.model.category == category }
            .reduce(0) { $0 + $1.model.amount }
    }
}

private extension ViewModel {
    func updateSummaryAmountText(with transactions: [TransactionListItemViewModel]) {
        let amount = transactions
            .filter { $0.isPinned }
            .reduce(0) { $0 + $1.model.amount }
        summaryAmountText = AmountFormatter.format(amount: amount)
    }

    func updateTransactionsList(with filter: CategoryModel) {
        switch filter {
        case .all:
            filteredTransactions = allTransactions
        case let .category(category):
            filteredTransactions = allTransactions
                .filter { $0.model.category == category }
        }
    }
}
