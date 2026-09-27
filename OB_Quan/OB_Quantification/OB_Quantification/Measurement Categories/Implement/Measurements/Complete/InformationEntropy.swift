//
//  InformationEntropy.swift
//  OB_Quantification
//

import Foundation

struct InformationEntropy: UnitCategory {
    var name: String
    let currentPage = "Information Entropy"
    let status = "Active"
    let isExportable = true

    let metric = [
        "Bit", "Shannon"
    ]

    let imperial: [String] = []

    let scientific = [
        "Nat"
    ]

    let nautical: [String] = []

    // Nat = Bit / log₂(e); Shannon ≡ Bit (base-2 entropy unit)
    private static let log2e = log2(M_E)

    func convertedValues(value: Double, from unit: String) -> [String:[String: Double]] {
        if metric.contains(unit) {
            return convertFromMetric(value, unit: unit)
        } else if scientific.contains(unit) {
            return convertFromScientific(value, unit: unit)
        }
        return [:]
    }

    // Base = bit (Shannon)
    private func convertFromMetric(_ value: Double, unit: String) -> [String:[String: Double]] {
        let bits: Double
        switch unit {
        case "Bit", "Shannon": bits = value
        default: bits = value
        }
        return mergeAll(bits)
    }

    private func convertFromScientific(_ value: Double, unit: String) -> [String:[String: Double]] {
        let bits: Double
        switch unit {
        case "Nat": bits = value * Self.log2e
        default: bits = value
        }
        return mergeAll(bits)
    }

    private func mergeAll(_ bits: Double) -> [String:[String: Double]] {
        var result = mergeMetricValues(bits)
        result.merge(mergeScientificValues(bits)) { c, _ in c }
        return result
    }

    private func mergeMetricValues(_ bits: Double) -> [String:[String: Double]] {
        ["Metric": [
            "Bit": bits,
            "Shannon": bits
        ]]
    }

    private func mergeScientificValues(_ bits: Double) -> [String:[String: Double]] {
        ["Scientific": ["Nat": bits / Self.log2e]]
    }
}
