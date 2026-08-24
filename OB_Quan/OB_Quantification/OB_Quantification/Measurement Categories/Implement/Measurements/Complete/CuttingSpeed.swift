//
//  CuttingSpeed.swift
//  OB_Quantification
//

import Foundation

struct CuttingSpeed: UnitCategory {
    var name: String
    let currentPage = "Cutting Speed"
    let status = "Active"
    let isExportable = true

    let metric = [
        "MeterPerMinute"
    ]

    let imperial = [
        "SurfaceFeetPerMinute"
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

    // Base = m/min; 1 ft/min = 0.3048 m/min
    private static let ftPerMinToMPerMin = 0.3048

    private func convertFromMetric(_ value: Double, unit: String) -> [String:[String: Double]] {
        let mpm: Double
        switch unit {
        case "MeterPerMinute": mpm = value
        default: mpm = value
        }
        return mergeAll(mpm)
    }

    private func convertFromImperial(_ value: Double, unit: String) -> [String:[String: Double]] {
        let mpm: Double
        switch unit {
        case "SurfaceFeetPerMinute": mpm = value * Self.ftPerMinToMPerMin
        default: mpm = value
        }
        return mergeAll(mpm)
    }

    private func mergeAll(_ mpm: Double) -> [String:[String: Double]] {
        var result = mergeMetricValues(mpm)
        result.merge(mergeImperialValues(mpm)) { c, _ in c }
        return result
    }

    private func mergeMetricValues(_ mpm: Double) -> [String:[String: Double]] {
        ["Metric": ["MeterPerMinute": mpm]]
    }

    private func mergeImperialValues(_ mpm: Double) -> [String:[String: Double]] {
        ["Imperial": ["SurfaceFeetPerMinute": mpm / Self.ftPerMinToMPerMin]]
    }
}
