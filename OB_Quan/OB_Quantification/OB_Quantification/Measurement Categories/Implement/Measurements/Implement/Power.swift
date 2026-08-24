//
//  Power.swift
//  OB_Quantification
//
//  Created by Arison on 11/28/25.
//

import Foundation

struct Power: UnitCategory {
    var name: String
    let currentPage = "Power"
    let status = "Active"
    let isExportable = true

    // MARK: - Unit Groups
    let metric = [
        "Watt", "Kilowatt", "Megawatt", "Gigawatt"
    ]

    let imperial = [
        "Horsepower" // mechanical horsepower ≈ 745.7 W
    ]

    let scientific: [String] = []

    let nautical: [String] = []

    // MARK: - Main Conversion Router
    func convertedValues(value: Double, from unit: String) -> [String:[String: Double]] {
        if metric.contains(unit) {
            return convertFromMetric(value, unit: unit)
        } else if imperial.contains(unit) {
            return convertFromImperial(value, unit: unit)
        }
        return [:]
    }

    // MARK: - Conversion Helpers (base = watt)
    private func convertFromMetric(_ value: Double, unit: String) -> [String:[String: Double]] {
        let toWatt: Double
        switch unit {
        case "Watt": toWatt = value
        case "Kilowatt": toWatt = value * 1000
        case "Megawatt": toWatt = value * 1e6
        case "Gigawatt": toWatt = value * 1e9
        default: toWatt = value
        }

        var result = mergeMetricValues(toWatt)
        result.merge(mergeImperialValues(toWatt)) { c, _ in c }
        return result
    }

    private func convertFromImperial(_ value: Double, unit: String) -> [String:[String: Double]] {
        let toWatt: Double
        switch unit {
        case "Horsepower": toWatt = value * 745.7
        default: toWatt = value
        }

        var result = mergeImperialValues(toWatt)
        result.merge(mergeMetricValues(toWatt)) { c, _ in c }
        return result
    }

    // MARK: - Merge Groups
    private func mergeMetricValues(_ value: Double) -> [String:[String: Double]] {
        [
            "Metric": [
                "Watt": value,
                "Kilowatt": value / 1000,
                "Megawatt": value / 1e6,
                "Gigawatt": value / 1e9
            ]
        ]
    }

    private func mergeImperialValues(_ value: Double) -> [String:[String: Double]] {
        [
            "Imperial": [
                "Horsepower": value / 745.7
            ]
        ]
    }
}
