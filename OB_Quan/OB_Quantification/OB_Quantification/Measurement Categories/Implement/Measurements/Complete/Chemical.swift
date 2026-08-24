//
//  Chemical.swift
//  OB_Quantification
//
//  Dynamic viscosity and molar concentration (convertible subsets).
// Hardness scales, octane numbers, etc. are not linear unit conversions.
//

import Foundation

struct Chemical: UnitCategory {
    var name: String
    let currentPage = "Chemical"
    let status = "In Progress"
    let isExportable = true

    // Dynamic viscosity — base = Pa·s
    let metric = [
        "PascalSecond", "MillipascalSecond"
    ]

    let imperial = [
        // 1 poiseuille = 1 Pa·s; kept under imperial group label for UI grouping of CGS
        "Poise", "Centipoise"
    ]

    // Molar concentration — base = mol/L
    let scientific = [
        "MolPerLiter", "MillimolPerLiter", "MicromolPerLiter"
    ]

    let nautical: [String] = []

    // TODO: not a convertible unit — requires reference calibration data:
    // Mohs/Vickers/Rockwell hardness, octane/cetane number, partition coefficient
    // without standard linear SI mapping, pH (logarithmic activity).

    func convertedValues(value: Double, from unit: String) -> [String:[String: Double]] {
        if metric.contains(unit) || imperial.contains(unit) {
            return convertViscosity(value, unit: unit)
        } else if scientific.contains(unit) {
            return convertConcentration(value, unit: unit)
        }
        return [:]
    }

    // MARK: - Viscosity (Pa·s)
    private func convertViscosity(_ value: Double, unit: String) -> [String:[String: Double]] {
        let pascalSecond: Double
        switch unit {
        case "PascalSecond": pascalSecond = value
        case "MillipascalSecond": pascalSecond = value * 1e-3
        case "Poise": pascalSecond = value * 0.1 // 1 P = 0.1 Pa·s (CGS)
        case "Centipoise": pascalSecond = value * 0.001 // 1 cP = 1 mPa·s
        default: pascalSecond = value
        }
        var result = mergeViscosityMetric(pascalSecond)
        result.merge(mergeViscosityImperial(pascalSecond)) { c, _ in c }
        return result
    }

    private func mergeViscosityMetric(_ pascalSecond: Double) -> [String:[String: Double]] {
        [
            "Metric": [
                "PascalSecond": pascalSecond,
                "MillipascalSecond": pascalSecond / 1e-3
            ]
        ]
    }

    private func mergeViscosityImperial(_ pascalSecond: Double) -> [String:[String: Double]] {
        [
            "Imperial": [
                "Poise": pascalSecond / 0.1,
                "Centipoise": pascalSecond / 0.001
            ]
        ]
    }

    // MARK: - Concentration (mol/L) — separate base; not merged with viscosity
    private func convertConcentration(_ value: Double, unit: String) -> [String:[String: Double]] {
        let molPerLiter: Double
        switch unit {
        case "MolPerLiter": molPerLiter = value
        case "MillimolPerLiter": molPerLiter = value * 1e-3
        case "MicromolPerLiter": molPerLiter = value * 1e-6
        default: molPerLiter = value
        }
        return [
            "Scientific": [
                "MolPerLiter": molPerLiter,
                "MillimolPerLiter": molPerLiter / 1e-3,
                "MicromolPerLiter": molPerLiter / 1e-6
            ]
        ]
    }
}
