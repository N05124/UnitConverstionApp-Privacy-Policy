//
//  Radioactivity.swift
//  OB_Quantification
//

import Foundation

struct Radioactivity: UnitCategory {
    var name: String
    let currentPage = "Radioactivity"
    let status = "Active"
    let isExportable = true

    let metric = [
        "Becquerel"
    ]

    let imperial: [String] = []

    let scientific = [
        "Curie"
    ]

    let nautical: [String] = []

    // 1 Ci = 3.7×10¹⁰ Bq (NIST conventional definition)
    private static let curieToBecquerel = 3.7e10

    func convertedValues(value: Double, from unit: String) -> [String:[String: Double]] {
        if metric.contains(unit) {
            return convertFromMetric(value, unit: unit)
        } else if scientific.contains(unit) {
            return convertFromScientific(value, unit: unit)
        }
        return [:]
    }

    private func convertFromMetric(_ value: Double, unit: String) -> [String:[String: Double]] {
        let becquerel: Double
        switch unit {
        case "Becquerel": becquerel = value
        default: becquerel = value
        }
        return mergeAll(becquerel)
    }

    private func convertFromScientific(_ value: Double, unit: String) -> [String:[String: Double]] {
        let becquerel: Double
        switch unit {
        case "Curie": becquerel = value * Self.curieToBecquerel
        default: becquerel = value
        }
        return mergeAll(becquerel)
    }

    private func mergeAll(_ becquerel: Double) -> [String:[String: Double]] {
        var result = mergeMetricValues(becquerel)
        result.merge(mergeScientificValues(becquerel)) { c, _ in c }
        return result
    }

    private func mergeMetricValues(_ becquerel: Double) -> [String:[String: Double]] {
        ["Metric": ["Becquerel": becquerel]]
    }

    private func mergeScientificValues(_ becquerel: Double) -> [String:[String: Double]] {
        ["Scientific": ["Curie": becquerel / Self.curieToBecquerel]]
    }
}
