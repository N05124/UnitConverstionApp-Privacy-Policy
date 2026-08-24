//
//  BaudRate.swift
//  OB_Quantification
//

import Foundation

struct BaudRate: UnitCategory {
    var name: String
    let currentPage = "Baud Rate"
    let status = "Active"
    let isExportable = true

    let metric = [
        "Baud"
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
        let baud: Double
        switch unit {
        case "Baud": baud = value
        default: baud = value
        }
        return mergeMetricValues(baud)
    }

    private func mergeMetricValues(_ baud: Double) -> [String:[String: Double]] {
        ["Metric": ["Baud": baud]]
    }
}
