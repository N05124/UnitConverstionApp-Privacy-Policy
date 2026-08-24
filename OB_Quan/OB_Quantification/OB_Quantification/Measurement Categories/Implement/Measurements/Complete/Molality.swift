//
//  Molality.swift
//  OB_Quantification
//

import Foundation

struct Molality: UnitCategory {
    var name: String
    let currentPage = "Molality"
    let status = "Active"
    let isExportable = true

    let metric = [
        "MolePerKilogram"
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
        let molPerKg: Double
        switch unit {
        case "MolePerKilogram": molPerKg = value
        default: molPerKg = value
        }
        return mergeMetricValues(molPerKg)
    }

    private func mergeMetricValues(_ molPerKg: Double) -> [String:[String: Double]] {
        ["Metric": ["MolePerKilogram": molPerKg]]
    }
}
