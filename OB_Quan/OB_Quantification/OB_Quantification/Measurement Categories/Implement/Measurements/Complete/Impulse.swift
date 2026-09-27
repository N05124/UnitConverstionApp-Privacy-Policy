//
//  Impulse.swift
//  OB_Quantification
//

import Foundation

struct Impulse: UnitCategory {
    var name: String
    let currentPage = "Impulse"
    let status = "Active"
    let isExportable = true

    let metric = [
        "NewtonSecond"
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
        let ns: Double
        switch unit {
        case "NewtonSecond": ns = value
        default: ns = value
        }
        return mergeMetricValues(ns)
    }

    private func mergeMetricValues(_ ns: Double) -> [String:[String: Double]] {
        ["Metric": ["NewtonSecond": ns]]
    }
}
