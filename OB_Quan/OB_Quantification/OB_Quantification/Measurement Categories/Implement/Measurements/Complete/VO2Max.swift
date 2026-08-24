//
//  VO2Max.swift
//  OB_Quantification
//

import Foundation

struct VO2Max: UnitCategory {
    var name: String
    let currentPage = "VO2 Max"
    let status = "Active"
    let isExportable = true

    let metric = [
        "MillilitersPerKilogramPerMinute"
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
        let mlKgMin: Double
        switch unit {
        case "MillilitersPerKilogramPerMinute": mlKgMin = value
        default: mlKgMin = value
        }
        return mergeMetricValues(mlKgMin)
    }

    private func mergeMetricValues(_ mlKgMin: Double) -> [String:[String: Double]] {
        ["Metric": ["MillilitersPerKilogramPerMinute": mlKgMin]]
    }
}
