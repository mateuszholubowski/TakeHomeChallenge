//
//  TechChallengeTests.swift
//  TechChallengeTests
//
//  Created by Adrian Tineo Cabello on 30/7/21.
//

import XCTest
@testable import TechChallenge

class TestViewModel: XCTestCase {

    func testSelectingAll() throws {
        let viewModel = ViewModel(transactions: TestViewModel.allTransactions, categories: TestViewModel.categories)
        viewModel.onCategoryFilterSelected(categoryFilter: .all)
        XCTAssertEqual(viewModel.filteredTransactionsModel, TestViewModel.allTransactions)
        XCTAssertEqual(viewModel.summaryAmountText, AmountFormatter.format(amount: 472.08))
    }

    func testEmptyTransactionListResult() throws {
        let viewModel = ViewModel(transactions: [], categories: TestViewModel.categories)
        viewModel.onCategoryFilterSelected(categoryFilter: .all)
        XCTAssertEqual(viewModel.filteredTransactionsModel, [])
        XCTAssertEqual(viewModel.summaryAmountText, AmountFormatter.format(amount: 0))
        viewModel.onCategoryFilterSelected(categoryFilter: .category(.food))
        XCTAssertEqual(viewModel.filteredTransactionsModel, [])
        XCTAssertEqual(viewModel.summaryAmountText, AmountFormatter.format(amount: 0))
    }

    func testSelectingCategoryWithEmptyResult() throws {
        let viewModel = ViewModel(transactions: TestViewModel.entertainmentTransactions, categories: TestViewModel.categories)
        viewModel.onCategoryFilterSelected(categoryFilter: .category(.food))
        XCTAssertEqual(viewModel.filteredTransactionsModel, [])
        XCTAssertEqual(viewModel.summaryAmountText, AmountFormatter.format(amount: 0))
    }

    func testChangingSelection() throws {
        let viewModel = ViewModel(transactions: TestViewModel.allTransactions, categories: TestViewModel.categories)
        viewModel.onCategoryFilterSelected(categoryFilter: .all)
        XCTAssertEqual(viewModel.filteredTransactionsModel, TestViewModel.allTransactions)
        XCTAssertEqual(viewModel.summaryAmountText, AmountFormatter.format(amount: 472.08))

        viewModel.onCategoryFilterSelected(categoryFilter: .category(.entertainment))
        XCTAssertEqual(viewModel.filteredTransactionsModel, TestViewModel.entertainmentTransactions)
        XCTAssertEqual(viewModel.summaryAmountText, AmountFormatter.format(amount: 82.99))

        viewModel.onCategoryFilterSelected(categoryFilter: .category(.shopping))
        XCTAssertEqual(viewModel.filteredTransactionsModel, TestViewModel.shopingTransactions)
        XCTAssertEqual(viewModel.summaryAmountText, AmountFormatter.format(amount: 78))
    }

    func testUnpinningTransactions() throws {
        let viewModel = ViewModel(transactions: TestViewModel.allTransactions, categories: TestViewModel.categories)
        viewModel.onCategoryFilterSelected(categoryFilter: .all)
        XCTAssertEqual(viewModel.filteredTransactionsModel, TestViewModel.allTransactions)
        XCTAssertEqual(viewModel.summaryAmountText, AmountFormatter.format(amount: 472.08))

        viewModel.onTransactionSelected(transaction: viewModel.filteredTransactions[0])
        XCTAssertEqual(viewModel.filteredTransactionsModel, TestViewModel.allTransactions)
        XCTAssertEqual(viewModel.summaryAmountText, AmountFormatter.format(amount: 472.08 - 82.99))

        viewModel.onTransactionSelected(transaction: viewModel.filteredTransactions[0])
        XCTAssertEqual(viewModel.filteredTransactionsModel, TestViewModel.allTransactions)
        XCTAssertEqual(viewModel.summaryAmountText, AmountFormatter.format(amount: 472.08))
    }
}

extension TestViewModel {
    static let categories = ModelData.categories

    static let allTransactions = ModelData.sampleTransactions

    static let entertainmentTransactions = [
        TransactionModel(
            id: 1,
            name: "Movie Night",
            category: .entertainment,
            amount: 82.99,
            date: Date(string: "2021-03-05")!,
            accountName: "any",
            provider: .timeWarner
        )
    ]

    static let shopingTransactions = [
        TransactionModel(
            id: 2,
            name: "Jeans",
            category: .shopping,
            amount: 54.60,
            date: Date(string: "2021-04-25")!,
            accountName: "any",
            provider: .jCrew
        ),
        TransactionModel(
            id: 6,
            name: "Monthly Best Seller",
            category: .shopping,
            amount: 6.51,
            date: Date(string: "2021-04-22")!,
            accountName: "any",
            provider: .amazon
        ),
        TransactionModel(
            id: 12,
            name: "Riders Cap",
            category: .shopping,
            amount: 16.89,
            date: Date(string: "2021-04-26")!,
            accountName: "any",
            provider: .jCrew
        )
    ]
}

extension TransactionModel: Equatable {
    public static func == (lhs: TransactionModel, rhs: TransactionModel) -> Bool {
        lhs.id == rhs.id
    }
}

extension ViewModel {
    var filteredTransactionsModel: [TransactionModel] {
        filteredTransactions.map { $0.model }
    }
}
