//
//  MolarMass.swift
//  OB_Quantification
//

import Foundation

struct MolarMass: UnitCategory {
    var name: String
    let currentPage = "Molar Mass"
    let status = "Active"
    let isExportable = true

    let metric = [
        "GramPerMole", "KilogramPerMole"
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

    // Base = g/mol
    private func convertFromMetric(_ value: Double, unit: String) -> [String:[String: Double]] {
        let gPerMol: Double
        switch unit {
        case "GramPerMole": gPerMol = value
        case "KilogramPerMole": gPerMol = value * 1000.0
        default: gPerMol = value
        }
        return mergeMetricValues(gPerMol)
    }

    private func mergeMetricValues(_ gPerMol: Double) -> [String:[String: Double]] {
        ["Metric": [
            "GramPerMole": gPerMol,
            "KilogramPerMole": gPerMol / 1000.0
        ]]
    }
}
