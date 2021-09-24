//
//  CategoryModel.swift
//  TechChallenge
//
//  Created by mholubowski on 24/09/2021.
//

import Foundation

// MARK: - Category

extension TransactionModel.Category: Identifiable {
    var id: String {
        rawValue
    }
}

extension TransactionModel.Category {
    static subscript(index: Int) -> Self? {
        guard
            index >= 0 &&
            index < TransactionModel.Category.allCases.count
        else {
            return nil
        }
        
        return TransactionModel.Category.allCases[index]
    }
}

enum CategoryModel {
    case all
    case category(TransactionModel.Category)
}

extension CategoryModel {
    var name: String {
        switch self {
        case .all:
            return "all"
        case let .category(category):
            return category.rawValue
        }
    }
}

extension CategoryModel: Identifiable {
    var id: String {
        name
    }
}
