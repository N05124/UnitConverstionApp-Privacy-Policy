//
//  safeString.swift
//  OB_Quantification
//
//  Created by Arison on 11/17/25.
//

import Foundation

extension Double {
    /// Returns a safe string representation of the number for display or precision view.
    /// - Very large or very small numbers use scientific notation
    /// - Normal numbers use fixed-point
    /// - Trailing zeros are removed
    /// - String is safely limited to 250 characters
    var trimmedDecimalString: String {
        let maxLength = 250
        let upperThreshold = 1e15      // numbers >= this use scientific notation
        let lowerThreshold = 1e-6      // numbers <= this use scientific notation
        
        let formatted: String
        
        if self == 0 {
            formatted = "0"
        } else if abs(self) >= upperThreshold || abs(self) <= lowerThreshold {
            // scientific notation for extreme values
            formatted = String(format: "%.15e", self)
        } else {
            // fixed-point for normal values
            let full = String(format: "%.50f", self)
            formatted = full
                .replacingOccurrences(of: #"0+$"#, with: "", options: .regularExpression)
                .replacingOccurrences(of: #"\.$"#, with: "", options: .regularExpression)
        }
        
        // limit string length safely
        if formatted.count > maxLength {
            let index = formatted.index(formatted.startIndex, offsetBy: maxLength)
            return String(formatted[..<index])
        }
        
        return formatted
    }
}
