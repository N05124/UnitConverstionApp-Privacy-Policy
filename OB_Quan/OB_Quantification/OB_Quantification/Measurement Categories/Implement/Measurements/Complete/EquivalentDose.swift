//
//  EquivalentDose.swift
//  OB_Quantification
//

import Foundation

struct EquivalentDose: UnitCategory {
    var name: String
    let currentPage = "Equivalent Dose"
    let status = "Active"
    let isExportable = true

    let metric = [
        "Sievert"
    ]

    let imperial: [String] = []

    let scientific = [
        "Rem"
    ]

    let nautical: [String] = []

    // 1 rem = 0.01 Sv (same energy-per-mass scaling as rad/Gy)
    private static let remToSievert = 0.01

    func convertedValues(value: Double, from unit: String) -> [String:[String: Double]] {
        if metric.contains(unit) {
            return convertFromMetric(value, unit: unit)
        } else if scientific.contains(unit) {
            return convertFromScientific(value, unit: unit)
        }
        return [:]
    }

    private func convertFromMetric(_ value: Double, unit: String) -> [String:[String: Double]] {
        let sievert: Double
        switch unit {
        case "Sievert": sievert = value
        default: sievert = value
        }
        return mergeAll(sievert)
    }

    private func convertFromScientific(_ value: Double, unit: String) -> [String:[String: Double]] {
        let sievert: Double
        switch unit {
        case "Rem": sievert = value * Self.remToSievert
        default: sievert = value
        }
        return mergeAll(sievert)
    }

    private func mergeAll(_ sievert: Double) -> [String:[String: Double]] {
        var result = mergeMetricValues(sievert)
        result.merge(mergeScientificValues(sievert)) { c, _ in c }
        return result
    }

    private func mergeMetricValues(_ sievert: Double) -> [String:[String: Double]] {
        ["Metric": ["Sievert": sievert]]
    }

    private func mergeScientificValues(_ sievert: Double) -> [String:[String: Double]] {
        ["Scientific": ["Rem": sievert / Self.remToSievert]]
    }
}
