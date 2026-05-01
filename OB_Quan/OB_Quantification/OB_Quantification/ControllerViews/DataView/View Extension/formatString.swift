//
//  formatString.swift
//  OB_Quantification
//
//  Created by Arison on 11/17/25.
//
//import Foundation
//extension Double {
//    var formattedSmart: String {
//        if self == 0 { return "0" }
//
//        let absValue = abs(self)
//        let plain = String(self)
//
//        // Rule 1: Swift already uses scientific → honor it
//        if plain.lowercased().contains("e") {
//            return String(format: "%e", self)
//        }
//
//        // Rule 2: Very large values → scientific
//        if absValue > 1_000_000 {
//            return String(format: "%e", self)
//        }
//
//        // Rule 3: More than 5 decimal places → scientific
//        if let decimalPart = plain.split(separator: ".").last,
//           plain.contains(".") {
//
//            if decimalPart.count > 5 {
//                return String(format: "%e", self)
//            }
//        }
//
//        // Default: plain formatting
//        return plain
//    }
//}

import Foundation

extension Double {
    var formattedSmart: String {
        if self == 0 { return "0" }

        let absValue = abs(self)

        // Convert to scientific notation
        let exponent = Int(floor(log10(absValue)))
        let mantissa = self / pow(10, Double(exponent))

        // Rule: Very large or small → scientific
        if absValue >= 1_000_000 || absValue < 0.001 {
            // One decimal place for mantissa
            let mantissaStr = String(format: "%.3f", mantissa)
            return "\(mantissaStr) * 1e\(exponent)"
        }

        // Default: one decimal place
        return String(format: "%.3f", self)
    }
}
