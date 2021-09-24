//
//  TransactionListItemViewModel.swift
//  TechChallenge
//
//  Created by mholubowski on 24/09/2021.
//

import Foundation

class TransactionListItemViewModel: ObservableObject {
    let model: TransactionModel
    @Published var isPinned: Bool = true

    init(model: TransactionModel) {
        self.model = model
    }
}

extension TransactionListItemViewModel: Identifiable {
    var id: Int {
        model.id
    }
}
