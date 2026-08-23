//
//  Hydrodynamic.swift
//  OB_Quantification
//
//  Volumetric and mass flow rates.
//

import Foundation

struct Hydrodynamic: UnitCategory {
    var name: String
    let currentPage = "Hydrodynamic"
    let status = "In Progress"
    let isExportable = true

    // Volumetric flow — base = m³/s
    let metric = [
        "CubicMeterPerSecond", "LiterPerSecond", "LiterPerMinute", "MilliliterPerSecond"
    ]

    let imperial = [
        "GallonPerMinute", "CubicFootPerSecond"
    ]

    // Mass flow — base = kg/s (separate dimension; converted only within scientific)
    let scientific = [
        "KilogramPerSecond", "GramPerSecond"
    ]

    let nautical: [String] = []

    // TODO: not a convertible unit without fluid/context data:
    // Reynolds, Froude, Strouhal numbers (dimensionless but need reference scales),
    // drag/lift coefficients.

    func convertedValues(value: Double, from unit: String) -> [String:[String: Double]] {
        if metric.contains(unit) || imperial.contains(unit) {
            return convertVolumetric(value, unit: unit)
        } else if scientific.contains(unit) {
            return convertMassFlow(value, unit: unit)
        }
        return [:]
    }

    private func convertVolumetric(_ value: Double, unit: String) -> [String:[String: Double]] {
        let m3s: Double
        switch unit {
        case "CubicMeterPerSecond": m3s = value
        case "LiterPerSecond": m3s = value * 0.001
        case "LiterPerMinute": m3s = value * 0.001 / 60.0
        case "MilliliterPerSecond": m3s = value * 1e-6
        case "GallonPerMinute": m3s = value * 3.78541e-3 / 60.0 // US gal
        case "CubicFootPerSecond": m3s = value * 0.0283168
        default: m3s = value
        }
        var result = mergeMetricVolumetric(m3s)
        result.merge(mergeImperialVolumetric(m3s)) { c, _ in c }
        return result
    }

    private func mergeMetricVolumetric(_ m3s: Double) -> [String:[String: Double]] {
        [
            "Metric": [
                "CubicMeterPerSecond": m3s,
                "LiterPerSecond": m3s / 0.001,
                "LiterPerMinute": m3s / (0.001 / 60.0),
                "MilliliterPerSecond": m3s / 1e-6
            ]
        ]
    }

    private func mergeImperialVolumetric(_ m3s: Double) -> [String:[String: Double]] {
        [
            "Imperial": [
                "GallonPerMinute": m3s / (3.78541e-3 / 60.0),
                "CubicFootPerSecond": m3s / 0.0283168
            ]
        ]
    }

    private func convertMassFlow(_ value: Double, unit: String) -> [String:[String: Double]] {
        let kgs: Double
        switch unit {
        case "KilogramPerSecond": kgs = value
        case "GramPerSecond": kgs = value / 1000.0
        default: kgs = value
        }
        return [
            "Scientific": [
                "KilogramPerSecond": kgs,
                "GramPerSecond": kgs * 1000.0
            ]
        ]
    }
}
