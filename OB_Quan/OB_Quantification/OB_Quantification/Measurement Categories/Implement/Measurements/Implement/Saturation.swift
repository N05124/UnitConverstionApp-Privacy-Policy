//
//  Saturation.swift
//  OB_Quantification
//
//  Created by Arison on 11/28/25.
//

import Foundation

/// Saturation / relative composition as percent or fraction.
/// Concentration units (mol/L) belong under Chemical — they are not convertible
/// to percent without a reference saturation concentration.
struct Saturation: UnitCategory {
    var name: String
    let currentPage = "Saturation"
    let status = "Active"
    let isExportable = true

    // MARK: - Unit Groups
    let metric = [
        "Percent", "Fraction"
    ]

    let imperial: [String] = []

    let scientific: [String] = []

    let nautical: [String] = []

    // MARK: - Main Conversion Router
    func convertedValues(value: Double, from unit: String) -> [String:[String: Double]] {
        if metric.contains(unit) {
            return convertFromMetric(value, unit: unit)
        }
        return [:]
    }

    // MARK: - Conversion Helpers (base = percent)
    private func convertFromMetric(_ value: Double, unit: String) -> [String:[String: Double]] {
        let toPercent: Double
        switch unit {
        case "Percent": toPercent = value
        case "Fraction": toPercent = value * 100
        default: toPercent = value
        }

        return mergeMetricValues(toPercent)
    }

    // MARK: - Merge Groups
    private func mergeMetricValues(_ value: Double) -> [String:[String: Double]] {
        [
            "Metric": [
                "Percent": value,
                "Fraction": value / 100
            ]
        ]
    }
}
