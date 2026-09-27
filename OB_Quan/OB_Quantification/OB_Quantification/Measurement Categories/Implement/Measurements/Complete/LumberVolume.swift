//
//  LumberVolume.swift
//  OB_Quantification
//

import Foundation

struct LumberVolume: UnitCategory {
    var name: String
    let currentPage = "Lumber Volume"
    let status = "Active"
    let isExportable = true

    let metric = [
        "CubicMeter"
    ]

    let imperial = [
        "BoardFoot", "CubicFoot"
    ]

    let scientific: [String] = []

    let nautical: [String] = []

    // 1 board-foot = 1 ft² × 1 in thick = 144 in³ = 0.0023597372 m³
    private static let boardFootToM3 = 0.0023597372
    // 1 ft³ = 0.0283168466 m³ (12 board-feet ≈ 1 cubic foot)
    private static let cubicFootToM3 = 0.0283168466

    func convertedValues(value: Double, from unit: String) -> [String:[String: Double]] {
        if metric.contains(unit) {
            return convertFromMetric(value, unit: unit)
        } else if imperial.contains(unit) {
            return convertFromImperial(value, unit: unit)
        }
        return [:]
    }

    private func convertFromMetric(_ value: Double, unit: String) -> [String:[String: Double]] {
        let m3: Double
        switch unit {
        case "CubicMeter": m3 = value
        default: m3 = value
        }
        return mergeAll(m3)
    }

    private func convertFromImperial(_ value: Double, unit: String) -> [String:[String: Double]] {
        let m3: Double
        switch unit {
        case "BoardFoot": m3 = value * Self.boardFootToM3
        case "CubicFoot": m3 = value * Self.cubicFootToM3
        default: m3 = value
        }
        return mergeAll(m3)
    }

    private func mergeAll(_ m3: Double) -> [String:[String: Double]] {
        var result = mergeMetricValues(m3)
        result.merge(mergeImperialValues(m3)) { c, _ in c }
        return result
    }

    private func mergeMetricValues(_ m3: Double) -> [String:[String: Double]] {
        ["Metric": ["CubicMeter": m3]]
    }

    private func mergeImperialValues(_ m3: Double) -> [String:[String: Double]] {
        ["Imperial": [
            "BoardFoot": m3 / Self.boardFootToM3,
            "CubicFoot": m3 / Self.cubicFootToM3
        ]]
    }
}
