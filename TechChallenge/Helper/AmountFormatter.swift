//
//  AmountFormatter.swift
//  TechChallenge
//
//  Created by mholubowski on 24/09/2021.
//

import Foundation

enum AmountFormatter {
    static func format(amount: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "$"
        return formatter.string(from: NSNumber(floatLiteral: amount)) ?? ""
    }
}
