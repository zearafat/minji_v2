//
//  Date+Extension.swift
//  useminji_3
//
//  Created by Alzea Arafat on 22/05/24.
//

import Foundation

extension Date {
    func formattedDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"  // Set the format to "Jan 01, 2024"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")  // Ensure the format is consistent
        return dateFormatter.string(from: self)
    }
}
