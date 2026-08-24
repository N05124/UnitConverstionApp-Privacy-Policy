//
//  Matter.swift
//  OB_Quantification
//
//  Amount of substance. Density is covered by Density.swift.
//

import Foundation

struct Matter: UnitCategory {
    var name: String
    let currentPage = "Matter"
    let status = "In Progress"
    let isExportable = true

    let metric = [
        "Mole", "Millimole", "Micromole", "Kilomole"
    ]

    let imperial: [String] = []

    let scientific = [
        "Mole", "ParticleCount" // N = n · N_A
    ]

    let nautical: [String] = []

    // Avogadro constant (CODATA 2019 exact)
    private static let avogadro = 6.02214076e23

    // TODO: not a convertible unit — requires reference calibration data:
    // crystal structure / lattice constants without specified lattice,
    // porosity without bulk/particle density pair, BET surface area context.

    func convertedValues(value: Double, from unit: String) -> [String:[String: Double]] {
        if metric.contains(unit) {
            return convertFromMetric(value, unit: unit)
        } else if scientific.contains(unit) {
            return convertFromScientific(value, unit: unit)
        }
        return [:]
    }

    private func convertFromMetric(_ value: Double, unit: String) -> [String:[String: Double]] {
        let moles: Double
        switch unit {
        case "Mole": moles = value
        case "Millimole": moles = value * 1e-3
        case "Micromole": moles = value * 1e-6
        case "Kilomole": moles = value * 1e3
        default: moles = value
        }
        var result = mergeMetricValues(moles)
        result.merge(mergeScientificValues(moles)) { c, _ in c }
        return result
    }

    private func convertFromScientific(_ value: Double, unit: String) -> [String:[String: Double]] {
        let moles: Double
        switch unit {
        case "Mole": moles = value
        case "ParticleCount": moles = value / Self.avogadro
        default: moles = value
        }
        var result = mergeScientificValues(moles)
        result.merge(mergeMetricValues(moles)) { c, _ in c }
        return result
    }

    private func mergeMetricValues(_ moles: Double) -> [String:[String: Double]] {
        [
            "Metric": [
                "Mole": moles,
                "Millimole": moles / 1e-3,
                "Micromole": moles / 1e-6,
                "Kilomole": moles / 1e3
            ]
        ]
    }

    private func mergeScientificValues(_ moles: Double) -> [String:[String: Double]] {
        [
            "Scientific": [
                "Mole": moles,
                "ParticleCount": moles * Self.avogadro
            ]
        ]
    }
}
