//
//  MassFlowRate.swift
//  OB_Quantification
//

import Foundation

struct MassFlowRate: UnitCategory {
    var name: String
    let currentPage = "Mass Flow"
    let status = "Active"
    let isExportable = true

    let metric = [
        "KilogramPerSecond"
    ]

    let imperial = [
        "PoundPerMinute"
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

    // 1 lb/min = 0.45359237 / 60 kg/s
    private static let lbPerMinToKgPerS = 0.45359237 / 60.0

    private func convertFromMetric(_ value: Double, unit: String) -> [String:[String: Double]] {
        let kgs: Double
        switch unit {
        case "KilogramPerSecond": kgs = value
        default: kgs = value
        }
        return mergeAll(kgs)
    }

    private func convertFromImperial(_ value: Double, unit: String) -> [String:[String: Double]] {
        let kgs: Double
        switch unit {
        case "PoundPerMinute": kgs = value * Self.lbPerMinToKgPerS
        default: kgs = value
        }
        return mergeAll(kgs)
    }

    private func mergeAll(_ kgs: Double) -> [String:[String: Double]] {
        var result = mergeMetricValues(kgs)
        result.merge(mergeImperialValues(kgs)) { c, _ in c }
        return result
    }

    private func mergeMetricValues(_ kgs: Double) -> [String:[String: Double]] {
        ["Metric": ["KilogramPerSecond": kgs]]
    }

    private func mergeImperialValues(_ kgs: Double) -> [String:[String: Double]] {
        ["Imperial": ["PoundPerMinute": kgs / Self.lbPerMinToKgPerS]]
    }
}
