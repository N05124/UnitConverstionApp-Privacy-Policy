//
//  Thermodynamic.swift
//  OB_Quantification
//
//  Temperature scales (affine). Pressure is covered by Pressure.swift;
// energy/heat quantities overlap Energy.swift.
//

import Foundation

struct Thermodynamic: UnitCategory {
    var name: String
    let currentPage = "Thermodynamic"
    let status = "In Progress"
    let isExportable = true

    let metric = [
        "Kelvin", "Celsius"
    ]

    let imperial = [
        "Fahrenheit", "Rankine"
    ]

    let scientific = [
        "Kelvin"
    ]

    let nautical: [String] = []

    // TODO: not a convertible unit — requires reference calibration data:
    // phase-equilibrium constants, chemical potential with composition context.

    func convertedValues(value: Double, from unit: String) -> [String:[String: Double]] {
        if metric.contains(unit) {
            return convertFromMetric(value, unit: unit)
        } else if imperial.contains(unit) {
            return convertFromImperial(value, unit: unit)
        } else if scientific.contains(unit) {
            return convertFromScientific(value, unit: unit)
        }
        return [:]
    }

    private func convertFromMetric(_ value: Double, unit: String) -> [String:[String: Double]] {
        let kelvin: Double
        switch unit {
        case "Kelvin": kelvin = value
        case "Celsius": kelvin = value + 273.15
        default: kelvin = value
        }
        return mergeAll(kelvin)
    }

    private func convertFromImperial(_ value: Double, unit: String) -> [String:[String: Double]] {
        let kelvin: Double
        switch unit {
        case "Fahrenheit": kelvin = (value - 32.0) * 5.0 / 9.0 + 273.15
        case "Rankine": kelvin = value * 5.0 / 9.0 // °R absolute
        default: kelvin = value
        }
        return mergeAll(kelvin)
    }

    private func convertFromScientific(_ value: Double, unit: String) -> [String:[String: Double]] {
        let kelvin = value // Kelvin
        return mergeAll(kelvin)
    }

    private func mergeAll(_ kelvin: Double) -> [String:[String: Double]] {
        var result = mergeMetricValues(kelvin)
        result.merge(mergeImperialValues(kelvin)) { c, _ in c }
        result.merge(mergeScientificValues(kelvin)) { c, _ in c }
        return result
    }

    private func mergeMetricValues(_ kelvin: Double) -> [String:[String: Double]] {
        [
            "Metric": [
                "Kelvin": kelvin,
                "Celsius": kelvin - 273.15
            ]
        ]
    }

    private func mergeImperialValues(_ kelvin: Double) -> [String:[String: Double]] {
        let celsius = kelvin - 273.15
        return [
            "Imperial": [
                "Fahrenheit": celsius * 9.0 / 5.0 + 32.0,
                "Rankine": kelvin * 9.0 / 5.0
            ]
        ]
    }

    private func mergeScientificValues(_ kelvin: Double) -> [String:[String: Double]] {
        ["Scientific": ["Kelvin": kelvin]]
    }
}
