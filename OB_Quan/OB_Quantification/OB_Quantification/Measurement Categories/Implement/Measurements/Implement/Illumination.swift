//
//  Illumination.swift
//  OB_Quantification
//
//  Created by Arison on 11/28/25.
//

import Foundation

struct Illumination: UnitCategory {
    var name: String
    let currentPage = "Illumination"
    let status = "Active"
    let isExportable = true

    // MARK: - Unit Groups
    let metric = [
        "Lux"
    ]

    let imperial = [
        "FootCandle"
    ]

    let scientific = [
        "Phot" // 1 phot = 10_000 lux (CGS)
    ]

    let nautical: [String] = []

    // MARK: - Main Conversion Router
    func convertedValues(value: Double, from unit: String) -> [String:[String: Double]] {
        if metric.contains(unit) {
            return convertFromMetric(value, unit: unit)
        } else if imperial.contains(unit) {
            return convertFromImperial(value, unit: unit)
        } else if scientific.contains(unit) {
            return convertFromScientific(value, unit: unit)
        }
        return [:]
    }

    // MARK: - Conversion Helpers (base = lux)
    private func convertFromMetric(_ value: Double, unit: String) -> [String:[String: Double]] {
        let toLux = value
        var result = mergeMetricValues(toLux)
        result.merge(mergeImperialValues(toLux)) { c, _ in c }
        result.merge(mergeScientificValues(toLux)) { c, _ in c }
        return result
    }

    private func convertFromImperial(_ value: Double, unit: String) -> [String:[String: Double]] {
        let toLux: Double
        switch unit {
        case "FootCandle": toLux = value * 10.7639 // 1 fc = 1 lm/ft²
        default: toLux = value
        }

        var result = mergeImperialValues(toLux)
        result.merge(mergeMetricValues(toLux)) { c, _ in c }
        result.merge(mergeScientificValues(toLux)) { c, _ in c }
        return result
    }

    private func convertFromScientific(_ value: Double, unit: String) -> [String:[String: Double]] {
        let toLux: Double
        switch unit {
        case "Phot": toLux = value * 10000
        default: toLux = value
        }

        var result = mergeScientificValues(toLux)
        result.merge(mergeMetricValues(toLux)) { c, _ in c }
        result.merge(mergeImperialValues(toLux)) { c, _ in c }
        return result
    }

    // MARK: - Merge Groups
    private func mergeMetricValues(_ value: Double) -> [String:[String: Double]] {
        ["Metric": ["Lux": value]]
    }

    private func mergeImperialValues(_ value: Double) -> [String:[String: Double]] {
        ["Imperial": ["FootCandle": value / 10.7639]]
    }

    private func mergeScientificValues(_ value: Double) -> [String:[String: Double]] {
        ["Scientific": ["Phot": value / 10000]]
    }
}
