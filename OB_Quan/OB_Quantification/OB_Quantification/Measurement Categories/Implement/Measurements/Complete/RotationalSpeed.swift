//
//  RotationalSpeed.swift
//  OB_Quantification
//

import Foundation

struct RotationalSpeed: UnitCategory {
    var name: String
    let currentPage = "Rotational Speed"
    let status = "Active"
    let isExportable = true

    let metric = [
        "RPM", "RadianPerSecond"
    ]

    let imperial = [
        "DegreePerSecond"
    ]

    let scientific: [String] = []

    let nautical: [String] = []

    func convertedValues(value: Double, from unit: String) -> [String:[String: Double]] {
        if metric.contains(unit) {
            return convertFromMetric(value, unit: unit)
        } else if imperial.contains(unit) {
            return convertFromImperial(value, unit: unit)
        }
        return [:]
    }

    // Base = rad/s
    private func convertFromMetric(_ value: Double, unit: String) -> [String:[String: Double]] {
        let radPerS: Double
        switch unit {
        case "RadianPerSecond": radPerS = value
        case "RPM": radPerS = value * 2.0 * Double.pi / 60.0
        default: radPerS = value
        }
        return mergeAll(radPerS)
    }

    private func convertFromImperial(_ value: Double, unit: String) -> [String:[String: Double]] {
        let radPerS: Double
        switch unit {
        case "DegreePerSecond": radPerS = value * Double.pi / 180.0
        default: radPerS = value
        }
        return mergeAll(radPerS)
    }

    private func mergeAll(_ radPerS: Double) -> [String:[String: Double]] {
        var result = mergeMetricValues(radPerS)
        result.merge(mergeImperialValues(radPerS)) { c, _ in c }
        return result
    }

    private func mergeMetricValues(_ radPerS: Double) -> [String:[String: Double]] {
        ["Metric": [
            "RadianPerSecond": radPerS,
            "RPM": radPerS * 60.0 / (2.0 * Double.pi)
        ]]
    }

    private func mergeImperialValues(_ radPerS: Double) -> [String:[String: Double]] {
        ["Imperial": ["DegreePerSecond": radPerS * 180.0 / Double.pi]]
    }
}
