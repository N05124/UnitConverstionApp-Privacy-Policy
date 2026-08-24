//
//  Luminance.swift
//  OB_Quantification
//

import Foundation

struct Luminance: UnitCategory {
    var name: String
    let currentPage = "Luminance"
    let status = "Active"
    let isExportable = true

    let metric = [
        "CandelaPerSquareMeter", "Nit"
    ]

    let imperial = [
        "FootLambert"
    ]

    let scientific: [String] = []

    let nautical: [String] = []

    func convertedValues(value: Double, from unit: String) -> [String:[String: Double]] {
        if metric.contains(unit) {
            return convertFromMetric(value, unit: unit)
        } else if imperial.contains(unit) {
            return convertFromImperial(value, unit: unit)
        }
        return [:]
    }

    // Base = cd/m² (nit ≡ cd/m²); 1 foot-lambert = (1/π) cd/ft² ≈ 3.426259 cd/m²
    private static let footLambertToCandelaPerSqM = 1.0 / Double.pi / (0.3048 * 0.3048)

    private func convertFromMetric(_ value: Double, unit: String) -> [String:[String: Double]] {
        let cdM2: Double
        switch unit {
        case "CandelaPerSquareMeter", "Nit": cdM2 = value
        default: cdM2 = value
        }
        return mergeAll(cdM2)
    }

    private func convertFromImperial(_ value: Double, unit: String) -> [String:[String: Double]] {
        let cdM2: Double
        switch unit {
        case "FootLambert": cdM2 = value * Self.footLambertToCandelaPerSqM
        default: cdM2 = value
        }
        return mergeAll(cdM2)
    }

    private func mergeAll(_ cdM2: Double) -> [String:[String: Double]] {
        var result = mergeMetricValues(cdM2)
        result.merge(mergeImperialValues(cdM2)) { c, _ in c }
        return result
    }

    private func mergeMetricValues(_ cdM2: Double) -> [String:[String: Double]] {
        ["Metric": [
            "CandelaPerSquareMeter": cdM2,
            "Nit": cdM2
        ]]
    }

    private func mergeImperialValues(_ cdM2: Double) -> [String:[String: Double]] {
        ["Imperial": ["FootLambert": cdM2 / Self.footLambertToCandelaPerSqM]]
    }
}
