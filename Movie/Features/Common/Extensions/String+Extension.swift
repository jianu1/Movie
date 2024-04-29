//
//  String+Extension.swift
//  Movie
//
//  Created by Marius Stefanita Jianu on 29.04.2024.
//

import Foundation

extension String {
    func toFormattedNumberString(maxFractionDigits: Int) -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = maxFractionDigits
        formatter.decimalSeparator = "."

        if let number = Double(self), let formattedString = formatter.string(from: NSNumber(value: number)) {
            return formattedString
        }
        return nil
    }
}
