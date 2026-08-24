//
//  VolumetricFlowRate.swift
//  OB_Quantification
//

import Foundation

struct VolumetricFlowRate: UnitCategory {
    var name: String
    let currentPage = "Volumetric Flow"
    let status = "Active"
    let isExportable = true

    let metric = [
        "CubicMeterPerSecond", "LiterPerMinute"
    ]

    let imperial = [
        "GallonPerMinute", "CubicFeetPerMinute"
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

    // Base = m³/s
    private static let literPerMinToM3s = 0.001 / 60.0
    private static let usGpmToM3s = 3.785411784e-3 / 60.0
    private static let cfmToM3s = 0.028316846592 / 60.0

    private func convertFromMetric(_ value: Double, unit: String) -> [String:[String: Double]] {
        let m3s: Double
        switch unit {
        case "CubicMeterPerSecond": m3s = value
        case "LiterPerMinute": m3s = value * Self.literPerMinToM3s
        default: m3s = value
        }
        return mergeAll(m3s)
    }

    private func convertFromImperial(_ value: Double, unit: String) -> [String:[String: Double]] {
        let m3s: Double
        switch unit {
        case "GallonPerMinute": m3s = value * Self.usGpmToM3s
        case "CubicFeetPerMinute": m3s = value * Self.cfmToM3s
        default: m3s = value
        }
        return mergeAll(m3s)
    }

    private func mergeAll(_ m3s: Double) -> [String:[String: Double]] {
        var result = mergeMetricValues(m3s)
        result.merge(mergeImperialValues(m3s)) { c, _ in c }
        return result
    }

    private func mergeMetricValues(_ m3s: Double) -> [String:[String: Double]] {
        ["Metric": [
            "CubicMeterPerSecond": m3s,
            "LiterPerMinute": m3s / Self.literPerMinToM3s
        ]]
    }

    private func mergeImperialValues(_ m3s: Double) -> [String:[String: Double]] {
        ["Imperial": [
            "GallonPerMinute": m3s / Self.usGpmToM3s,
            "CubicFeetPerMinute": m3s / Self.cfmToM3s
        ]]
    }
}
