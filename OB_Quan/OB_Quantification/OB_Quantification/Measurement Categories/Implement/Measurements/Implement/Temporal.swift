//
//  Temporal.swift
//  OB_Quantification
//
//  Created by Arison on 11/28/25.
//

import Foundation

struct Temporal: UnitCategory {
    var name: String
    let currentPage = "Time"
    let status = "Active"
    let isExportable = true

    // MARK: - Unit Groups
    let metric = [
        "Millisecond", "Second", "Minute", "Hour", "Day", "Week"
    ]

    let imperial: [String] = []

    let nautical: [String] = []

    let scientific = [
        "PlanckTime", "Nanosecond", "Microsecond", "Millisecond",
        "Second", "Kilosecond", "Megasecond",
        "Month(30d)", "Year(365d)", "Decade", "Century",
        "Millennium", "JulianYear"
    ]

    // MARK: - Main Conversion Router
    func convertedValues(value: Double, from unit: String) -> [String:[String: Double]] {
        if metric.contains(unit) {
            return convertFromMetric(value, unit: unit)
        } else if scientific.contains(unit) {
            return convertFromScientific(value, unit: unit)
        } else {
            return [:]
        }
    }

    // MARK: - Conversion Helpers (base = seconds)
    private func convertFromMetric(_ value: Double, unit: String) -> [String:[String: Double]] {
        let toSeconds: Double
        switch unit {
        case "Millisecond": toSeconds = value / 1000
        case "Second": toSeconds = value
        case "Minute": toSeconds = value * 60
        case "Hour": toSeconds = value * 3600
        case "Day": toSeconds = value * 86400
        case "Week": toSeconds = value * 604800
        default: toSeconds = value
        }

        var result = mergeMetricValues(toSeconds)
        result.merge(mergeScientificValues(toSeconds)) { c, _ in c }
        return result
    }

    private func convertFromScientific(_ value: Double, unit: String) -> [String:[String: Double]] {
        let toSeconds: Double
        switch unit {
        case "PlanckTime": toSeconds = value * 5.39e-44 // ℏG/c⁵)^(1/2)
        case "Nanosecond": toSeconds = value * 1e-9
        case "Microsecond": toSeconds = value * 1e-6
        case "Millisecond": toSeconds = value / 1000
        case "Second": toSeconds = value
        case "Kilosecond": toSeconds = value * 1000
        case "Megasecond": toSeconds = value * 1e6
        case "Month(30d)": toSeconds = value * 2_592_000
        case "Year(365d)": toSeconds = value * 31_536_000
        case "Decade": toSeconds = value * 315_360_000
        case "Century": toSeconds = value * 3_153_600_000
        case "Millennium": toSeconds = value * 31_536_000_000
        case "JulianYear": toSeconds = value * 31_557_600 // 365.25 d
        default: toSeconds = value
        }

        var result = mergeScientificValues(toSeconds)
        result.merge(mergeMetricValues(toSeconds)) { c, _ in c }
        return result
    }

    // MARK: - Merge Groups
    private func mergeMetricValues(_ value: Double) -> [String:[String: Double]] {
        [
            "Metric": [
                "Millisecond": value * 1000,
                "Second": value,
                "Minute": value / 60,
                "Hour": value / 3600,
                "Day": value / 86400,
                "Week": value / 604800
            ]
        ]
    }

    private func mergeScientificValues(_ value: Double) -> [String:[String: Double]] {
        [
            "Scientific": [
                "PlanckTime": value / 5.39e-44,
                "Nanosecond": value / 1e-9,
                "Microsecond": value / 1e-6,
                "Millisecond": value * 1000,
                "Second": value,
                "Kilosecond": value / 1000,
                "Megasecond": value / 1e6,
                "Month(30d)": value / 2_592_000,
                "Year(365d)": value / 31_536_000,
                "Decade": value / 315_360_000,
                "Century": value / 3_153_600_000,
                "Millennium": value / 31_536_000_000,
                "JulianYear": value / 31_557_600
            ]
        ]
    }
}
