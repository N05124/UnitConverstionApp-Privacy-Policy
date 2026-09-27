//
//  Jerk.swift
//  OB_Quantification
//

import Foundation

struct Jerk: UnitCategory {
    var name: String
    let currentPage = "Jerk"
    let status = "Active"
    let isExportable = true

    let metric = [
        "MeterPerSecondCubed"
    ]

    let imperial: [String] = []

    let scientific: [String] = []

    let nautical: [String] = []

    func convertedValues(value: Double, from unit: String) -> [String:[String: Double]] {
        if metric.contains(unit) {
            return convertFromMetric(value, unit: unit)
        }
        return [:]
    }

    private func convertFromMetric(_ value: Double, unit: String) -> [String:[String: Double]] {
        let mPerS3: Double
        switch unit {
        case "MeterPerSecondCubed": mPerS3 = value
        default: mPerS3 = value
        }
        return mergeMetricValues(mPerS3)
    }

    private func mergeMetricValues(_ mPerS3: Double) -> [String:[String: Double]] {
        ["Metric": ["MeterPerSecondCubed": mPerS3]]
    }
}
