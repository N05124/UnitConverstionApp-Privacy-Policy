//
//  Frequency.swift
//  OB_Quantification
//
//  Created by Arison on 11/28/25.
//

import Foundation

struct Frequency: UnitCategory {
    var name: String
    let currentPage = "Frequency"
    let status = "Active"
    let isExportable = true

    // MARK: - Unit Groups
    let metric = [
        "Hertz", "Kilohertz", "Megahertz", "Gigahertz"
    ]

    let imperial: [String] = []

    let scientific = [
        "RadianPerSecond"
    ]

    let nautical: [String] = []

    // MARK: - Main Conversion Router
    func convertedValues(value: Double, from unit: String) -> [String:[String: Double]] {
        if metric.contains(unit) {
            return convertFromMetric(value, unit: unit)
        } else if scientific.contains(unit) {
            return convertFromScientific(value, unit: unit)
        }
        return [:]
    }

    // MARK: - Conversion Helpers (base = Hz)
    private func convertFromMetric(_ value: Double, unit: String) -> [String:[String: Double]] {
        let toHz: Double
        switch unit {
        case "Hertz": toHz = value
        case "Kilohertz": toHz = value * 1e3
        case "Megahertz": toHz = value * 1e6
        case "Gigahertz": toHz = value * 1e9
        default: toHz = value
        }

        var result = mergeMetricValues(toHz)
        result.merge(mergeScientificValues(toHz)) { c, _ in c }
        return result
    }

    private func convertFromScientific(_ value: Double, unit: String) -> [String:[String: Double]] {
        let toHz: Double
        switch unit {
        // ω (rad/s) = 2π f
        case "RadianPerSecond": toHz = value / (2 * Double.pi)
        default: toHz = value
        }

        var result = mergeScientificValues(toHz)
        result.merge(mergeMetricValues(toHz)) { c, _ in c }
        return result
    }

    // MARK: - Merge Groups
    private func mergeMetricValues(_ value: Double) -> [String:[String: Double]] {
        [
            "Metric": [
                "Hertz": value,
                "Kilohertz": value / 1e3,
                "Megahertz": value / 1e6,
                "Gigahertz": value / 1e9
            ]
        ]
    }

    private func mergeScientificValues(_ value: Double) -> [String:[String: Double]] {
        [
            "Scientific": [
                "RadianPerSecond": value * 2 * Double.pi
            ]
        ]
    }
}
