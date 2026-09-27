//
//  FeedRate.swift
//  OB_Quantification
//

import Foundation

struct FeedRate: UnitCategory {
    var name: String
    let currentPage = "Feed Rate"
    let status = "Active"
    let isExportable = true

    let metric = [
        "MillimeterPerMinute"
    ]

    let imperial = [
        "InchPerMinute"
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

    // Base = mm/min; 1 in/min = 25.4 mm/min
    private static let inchToMm = 25.4

    private func convertFromMetric(_ value: Double, unit: String) -> [String:[String: Double]] {
        let mmMin: Double
        switch unit {
        case "MillimeterPerMinute": mmMin = value
        default: mmMin = value
        }
        return mergeAll(mmMin)
    }

    private func convertFromImperial(_ value: Double, unit: String) -> [String:[String: Double]] {
        let mmMin: Double
        switch unit {
        case "InchPerMinute": mmMin = value * Self.inchToMm
        default: mmMin = value
        }
        return mergeAll(mmMin)
    }

    private func mergeAll(_ mmMin: Double) -> [String:[String: Double]] {
        var result = mergeMetricValues(mmMin)
        result.merge(mergeImperialValues(mmMin)) { c, _ in c }
        return result
    }

    private func mergeMetricValues(_ mmMin: Double) -> [String:[String: Double]] {
        ["Metric": ["MillimeterPerMinute": mmMin]]
    }

    private func mergeImperialValues(_ mmMin: Double) -> [String:[String: Double]] {
        ["Imperial": ["InchPerMinute": mmMin / Self.inchToMm]]
    }
}
