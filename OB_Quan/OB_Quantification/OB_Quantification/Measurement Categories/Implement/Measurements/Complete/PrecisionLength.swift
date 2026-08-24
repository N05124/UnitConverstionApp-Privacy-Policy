//
//  PrecisionLength.swift
//  OB_Quantification
//

import Foundation

struct PrecisionLength: UnitCategory {
    var name: String
    let currentPage = "Precision Length"
    let status = "Active"
    let isExportable = true

    let metric = [
        "Micron"
    ]

    let imperial = [
        "Thou", "Mil"
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

    // Base = meters; Thou/Mil = 0.001 in = 25.4 µm; Micron = 1 µm
    private static let thouMeters = 0.001 * 0.0254

    private func convertFromMetric(_ value: Double, unit: String) -> [String:[String: Double]] {
        let meters: Double
        switch unit {
        case "Micron": meters = value * 1e-6
        default: meters = value
        }
        return mergeAll(meters)
    }

    private func convertFromImperial(_ value: Double, unit: String) -> [String:[String: Double]] {
        let meters: Double
        switch unit {
        case "Thou", "Mil": meters = value * Self.thouMeters
        default: meters = value
        }
        return mergeAll(meters)
    }

    private func mergeAll(_ meters: Double) -> [String:[String: Double]] {
        var result = mergeMetricValues(meters)
        result.merge(mergeImperialValues(meters)) { c, _ in c }
        return result
    }

    private func mergeMetricValues(_ meters: Double) -> [String:[String: Double]] {
        ["Metric": ["Micron": meters / 1e-6]]
    }

    private func mergeImperialValues(_ meters: Double) -> [String:[String: Double]] {
        let thou = meters / Self.thouMeters
        return ["Imperial": [
            "Thou": thou,
            "Mil": thou
        ]]
    }
}
