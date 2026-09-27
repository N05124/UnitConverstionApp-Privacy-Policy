//
//  EngineDisplacement.swift
//  OB_Quantification
//

import Foundation

struct EngineDisplacement: UnitCategory {
    var name: String
    let currentPage = "Engine Displacement"
    let status = "Active"
    let isExportable = true

    let metric = [
        "Liter", "CubicCentimeter"
    ]

    let imperial = [
        "CubicInch"
    ]

    let scientific: [String] = []

    let nautical: [String] = []

    // 1 in³ = 0.0163871 L (NIST)
    private static let cubicInchToLiter = 0.0163871

    func convertedValues(value: Double, from unit: String) -> [String:[String: Double]] {
        if metric.contains(unit) {
            return convertFromMetric(value, unit: unit)
        } else if imperial.contains(unit) {
            return convertFromImperial(value, unit: unit)
        }
        return [:]
    }

    // Base = Liter
    private func convertFromMetric(_ value: Double, unit: String) -> [String:[String: Double]] {
        let liters: Double
        switch unit {
        case "Liter": liters = value
        case "CubicCentimeter": liters = value / 1000.0
        default: liters = value
        }
        return mergeAll(liters)
    }

    private func convertFromImperial(_ value: Double, unit: String) -> [String:[String: Double]] {
        let liters: Double
        switch unit {
        case "CubicInch": liters = value * Self.cubicInchToLiter
        default: liters = value
        }
        return mergeAll(liters)
    }

    private func mergeAll(_ liters: Double) -> [String:[String: Double]] {
        var result = mergeMetricValues(liters)
        result.merge(mergeImperialValues(liters)) { c, _ in c }
        return result
    }

    private func mergeMetricValues(_ liters: Double) -> [String:[String: Double]] {
        ["Metric": [
            "Liter": liters,
            "CubicCentimeter": liters * 1000.0
        ]]
    }

    private func mergeImperialValues(_ liters: Double) -> [String:[String: Double]] {
        ["Imperial": ["CubicInch": liters / Self.cubicInchToLiter]]
    }
}
