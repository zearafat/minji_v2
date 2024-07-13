//
//  Double+Extension.swift
//  useminji_3
//
//  Created by Alzea Arafat on 15/05/24.
//

import Foundation

extension Double {
    func formattedAsDollar() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "$ "
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 0
        return formatter.string(from: NSNumber(value: self)) ?? ""
    }
}
