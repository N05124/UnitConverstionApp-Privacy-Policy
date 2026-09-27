//
//  LuminousIntensity.swift
//  OB_Quantification
//

import Foundation

struct LuminousIntensity: UnitCategory {
    var name: String
    let currentPage = "Luminous Intensity"
    let status = "Active"
    let isExportable = true

    let metric = [
        "Candela"
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
        mergeMetricValues(value)
    }

    private func mergeMetricValues(_ cd: Double) -> [String:[String: Double]] {
        ["Metric": ["Candela": cd]]
    }
}
