//
//  KinematicViscosity.swift
//  OB_Quantification
//

import Foundation

struct KinematicViscosity: UnitCategory {
    var name: String
    let currentPage = "Kinematic Viscosity"
    let status = "Active"
    let isExportable = true

    let metric = [
        "SquareMeterPerSecond"
    ]

    let imperial = [
        "Stokes", "Centistokes"
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

    // Base = m²/s; 1 stoke = 1e-4 m²/s; 1 cSt = 1e-6 m²/s
    private func convertFromMetric(_ value: Double, unit: String) -> [String:[String: Double]] {
        let m2s: Double
        switch unit {
        case "SquareMeterPerSecond": m2s = value
        default: m2s = value
        }
        return mergeAll(m2s)
    }

    private func convertFromImperial(_ value: Double, unit: String) -> [String:[String: Double]] {
        let m2s: Double
        switch unit {
        case "Stokes": m2s = value * 1e-4
        case "Centistokes": m2s = value * 1e-6
        default: m2s = value
        }
        return mergeAll(m2s)
    }

    private func mergeAll(_ m2s: Double) -> [String:[String: Double]] {
        var result = mergeMetricValues(m2s)
        result.merge(mergeImperialValues(m2s)) { c, _ in c }
        return result
    }

    private func mergeMetricValues(_ m2s: Double) -> [String:[String: Double]] {
        ["Metric": ["SquareMeterPerSecond": m2s]]
    }

    private func mergeImperialValues(_ m2s: Double) -> [String:[String: Double]] {
        ["Imperial": [
            "Stokes": m2s / 1e-4,
            "Centistokes": m2s / 1e-6
        ]]
    }
}
