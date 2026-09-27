//
//  AngularMomentum.swift
//  OB_Quantification
//

import Foundation

struct AngularMomentum: UnitCategory {
    var name: String
    let currentPage = "Angular Momentum"
    let status = "Active"
    let isExportable = true

    let metric = [
        "KilogramMeterSquaredPerSecond"
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
        let kgm2PerS: Double
        switch unit {
        case "KilogramMeterSquaredPerSecond": kgm2PerS = value
        default: kgm2PerS = value
        }
        return mergeMetricValues(kgm2PerS)
    }

    private func mergeMetricValues(_ kgm2PerS: Double) -> [String:[String: Double]] {
        ["Metric": ["KilogramMeterSquaredPerSecond": kgm2PerS]]
    }
}
