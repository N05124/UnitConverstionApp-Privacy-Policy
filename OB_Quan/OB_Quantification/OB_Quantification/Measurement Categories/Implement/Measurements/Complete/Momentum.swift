//
//  Momentum.swift
//  OB_Quantification
//

import Foundation

struct Momentum: UnitCategory {
    var name: String
    let currentPage = "Momentum"
    let status = "Active"
    let isExportable = true

    let metric = [
        "KilogramMeterPerSecond"
    ]

    let imperial = [
        "PoundFootPerSecond"
    ]

    let scientific: [String] = []

    let nautical: [String] = []

    // 1 lb·ft/s = 0.45359237 kg × 0.3048 m/s (NIST)
    private static let lbFtPerSToKgMPerS = 0.45359237 * 0.3048

    func convertedValues(value: Double, from unit: String) -> [String:[String: Double]] {
        if metric.contains(unit) {
            return convertFromMetric(value, unit: unit)
        } else if imperial.contains(unit) {
            return convertFromImperial(value, unit: unit)
        }
        return [:]
    }

    private func convertFromMetric(_ value: Double, unit: String) -> [String:[String: Double]] {
        let kgmPerS: Double
        switch unit {
        case "KilogramMeterPerSecond": kgmPerS = value
        default: kgmPerS = value
        }
        return mergeAll(kgmPerS)
    }

    private func convertFromImperial(_ value: Double, unit: String) -> [String:[String: Double]] {
        let kgmPerS: Double
        switch unit {
        case "PoundFootPerSecond": kgmPerS = value * Self.lbFtPerSToKgMPerS
        default: kgmPerS = value
        }
        return mergeAll(kgmPerS)
    }

    private func mergeAll(_ kgmPerS: Double) -> [String:[String: Double]] {
        var result = mergeMetricValues(kgmPerS)
        result.merge(mergeImperialValues(kgmPerS)) { c, _ in c }
        return result
    }

    private func mergeMetricValues(_ kgmPerS: Double) -> [String:[String: Double]] {
        ["Metric": ["KilogramMeterPerSecond": kgmPerS]]
    }

    private func mergeImperialValues(_ kgmPerS: Double) -> [String:[String: Double]] {
        ["Imperial": ["PoundFootPerSecond": kgmPerS / Self.lbFtPerSToKgMPerS]]
    }
}
