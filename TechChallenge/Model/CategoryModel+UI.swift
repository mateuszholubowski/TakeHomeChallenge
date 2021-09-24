//
//  TransactionModel+UI.swift
//  TechChallenge
//
//  Created by Adrian Tineo Cabello on 12/8/21.
//

import SwiftUI

extension CategoryModel {
    var color: Color {
        switch self {
        case .all:
            return .black
        case let .category(category):
            return category.color
        }
    }
}
