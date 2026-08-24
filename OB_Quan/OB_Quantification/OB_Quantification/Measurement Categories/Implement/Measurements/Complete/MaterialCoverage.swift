//
//  MaterialCoverage.swift
//  OB_Quantification
//

import Foundation

struct MaterialCoverage: UnitCategory {
    var name: String
    let currentPage = "Material Coverage"
    let status = "Active"
    let isExportable = true

    let metric = [
        "SquareMeterPerLiter"
    ]

    let imperial = [
        "SquareFeetPerGallon"
    ]

    let scientific: [String] = []

    let nautical: [String] = []

    // 1 ft²/gal = 0.09290304 m²/ft² ÷ 3.785411784 L/gal ≈ 0.024543 m²/L
    private static let sqFtPerGalToSqMPerL = 0.024543

    func convertedValues(value: Double, from unit: String) -> [String:[String: Double]] {
        if metric.contains(unit) {
            return convertFromMetric(value, unit: unit)
        } else if imperial.contains(unit) {
            return convertFromImperial(value, unit: unit)
        }
        return [:]
    }

    private func convertFromMetric(_ value: Double, unit: String) -> [String:[String: Double]] {
        let m2PerL: Double
        switch unit {
        case "SquareMeterPerLiter": m2PerL = value
        default: m2PerL = value
        }
        return mergeAll(m2PerL)
    }

    private func convertFromImperial(_ value: Double, unit: String) -> [String:[String: Double]] {
        let m2PerL: Double
        switch unit {
        case "SquareFeetPerGallon": m2PerL = value * Self.sqFtPerGalToSqMPerL
        default: m2PerL = value
        }
        return mergeAll(m2PerL)
    }

    private func mergeAll(_ m2PerL: Double) -> [String:[String: Double]] {
        var result = mergeMetricValues(m2PerL)
        result.merge(mergeImperialValues(m2PerL)) { c, _ in c }
        return result
    }

    private func mergeMetricValues(_ m2PerL: Double) -> [String:[String: Double]] {
        ["Metric": ["SquareMeterPerLiter": m2PerL]]
    }

    private func mergeImperialValues(_ m2PerL: Double) -> [String:[String: Double]] {
        ["Imperial": ["SquareFeetPerGallon": m2PerL / Self.sqFtPerGalToSqMPerL]]
    }
}
