//
//  Exposure.swift
//  OB_Quantification
//

import Foundation

struct Exposure: UnitCategory {
    var name: String
    let currentPage = "Exposure"
    let status = "Active"
    let isExportable = true

    let metric = [
        "CoulombPerKilogram"
    ]

    let imperial: [String] = []

    let scientific = [
        "Roentgen"
    ]

    let nautical: [String] = []

    // 1 R = 2.58×10⁻⁴ C/kg (NIST exact conventional value)
    private static let roentgenToCoulombPerKg = 2.58e-4

    func convertedValues(value: Double, from unit: String) -> [String:[String: Double]] {
        if metric.contains(unit) {
            return convertFromMetric(value, unit: unit)
        } else if scientific.contains(unit) {
            return convertFromScientific(value, unit: unit)
        }
        return [:]
    }

    private func convertFromMetric(_ value: Double, unit: String) -> [String:[String: Double]] {
        let cPerKg: Double
        switch unit {
        case "CoulombPerKilogram": cPerKg = value
        default: cPerKg = value
        }
        return mergeAll(cPerKg)
    }

    private func convertFromScientific(_ value: Double, unit: String) -> [String:[String: Double]] {
        let cPerKg: Double
        switch unit {
        case "Roentgen": cPerKg = value * Self.roentgenToCoulombPerKg
        default: cPerKg = value
        }
        return mergeAll(cPerKg)
    }

    private func mergeAll(_ cPerKg: Double) -> [String:[String: Double]] {
        var result = mergeMetricValues(cPerKg)
        result.merge(mergeScientificValues(cPerKg)) { c, _ in c }
        return result
    }

    private func mergeMetricValues(_ cPerKg: Double) -> [String:[String: Double]] {
        ["Metric": ["CoulombPerKilogram": cPerKg]]
    }

    private func mergeScientificValues(_ cPerKg: Double) -> [String:[String: Double]] {
        ["Scientific": ["Roentgen": cPerKg / Self.roentgenToCoulombPerKg]]
    }
}
