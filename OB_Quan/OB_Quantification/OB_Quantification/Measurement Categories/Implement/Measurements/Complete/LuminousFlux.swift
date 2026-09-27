//
//  LuminousFlux.swift
//  OB_Quantification
//

import Foundation

struct LuminousFlux: UnitCategory {
    var name: String
    let currentPage = "Luminous Flux"
    let status = "Active"
    let isExportable = true

    let metric = [
        "Lumen"
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
        let lumens = value
        return mergeMetricValues(lumens)
    }

    private func mergeMetricValues(_ lumens: Double) -> [String:[String: Double]] {
        ["Metric": ["Lumen": lumens]]
    }
}
