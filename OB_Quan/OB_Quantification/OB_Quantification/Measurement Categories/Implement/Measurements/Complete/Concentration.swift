//
//  Concentration.swift
//  OB_Quantification
//

import Foundation

struct Concentration: UnitCategory {
    var name: String
    let currentPage = "Concentration"
    let status = "Active"
    let isExportable = true

    let metric = [
        "PartsPerMillion", "PartsPerBillion", "PartsPerTrillion", "MilligramPerLiter"
    ]

    let imperial: [String] = []

    let scientific: [String] = []

    let nautical: [String] = []

    // ppm/ppb/ppt are dimensionless mass ratios; mg/L ↔ ppm assumes aqueous
    // reference density of 1 kg/L (water at ~4 °C / standard dilute solutions).

    func convertedValues(value: Double, from unit: String) -> [String:[String: Double]] {
        if metric.contains(unit) {
            return convertFromMetric(value, unit: unit)
        }
        return [:]
    }

    // Base = parts per million (ppm)
    private func convertFromMetric(_ value: Double, unit: String) -> [String:[String: Double]] {
        let ppm: Double
        switch unit {
        case "PartsPerMillion": ppm = value
        case "PartsPerBillion": ppm = value / 1000.0
        case "PartsPerTrillion": ppm = value / 1_000_000.0
        case "MilligramPerLiter": ppm = value // 1 mg/L ≈ 1 ppm when ρ = 1 kg/L
        default: ppm = value
        }
        return mergeMetricValues(ppm)
    }

    private func mergeMetricValues(_ ppm: Double) -> [String:[String: Double]] {
        ["Metric": [
            "PartsPerMillion": ppm,
            "PartsPerBillion": ppm * 1000.0,
            "PartsPerTrillion": ppm * 1_000_000.0,
            "MilligramPerLiter": ppm
        ]]
    }
}
