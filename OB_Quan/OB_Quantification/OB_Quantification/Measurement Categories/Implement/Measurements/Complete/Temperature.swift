//
//  Temperature.swift
//  OB_Quantification
//

import Foundation

struct Temperature: UnitCategory {
    var name: String
    let currentPage = "Temperature"
    let status = "Active"
    let isExportable = true

    let metric = [
        "Celsius", "Kelvin"
    ]

    let imperial = [
        "Fahrenheit", "Rankine"
    ]

    let scientific = [
        "Kelvin"
    ]

    let nautical: [String] = []

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

    // Base = kelvin (affine transforms for °C / °F — not multiplicative)
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
        case "Rankine": kelvin = value * 5.0 / 9.0
        default: kelvin = value
        }
        return mergeAll(kelvin)
    }

    private func convertFromScientific(_ value: Double, unit: String) -> [String:[String: Double]] {
        mergeAll(value)
    }

    private func mergeAll(_ kelvin: Double) -> [String:[String: Double]] {
        var result = mergeMetricValues(kelvin)
        result.merge(mergeImperialValues(kelvin)) { c, _ in c }
        result.merge(mergeScientificValues(kelvin)) { c, _ in c }
        result.merge(mergeNauticalValues(kelvin)) { c, _ in c }
        return result
    }

    private func mergeMetricValues(_ kelvin: Double) -> [String:[String: Double]] {
        ["Metric": [
            "Celsius": kelvin - 273.15,
            "Kelvin": kelvin
        ]]
    }

    private func mergeImperialValues(_ kelvin: Double) -> [String:[String: Double]] {
        let celsius = kelvin - 273.15
        return ["Imperial": [
            "Fahrenheit": celsius * 9.0 / 5.0 + 32.0,
            "Rankine": kelvin * 9.0 / 5.0
        ]]
    }

    private func mergeScientificValues(_ kelvin: Double) -> [String:[String: Double]] {
        ["Scientific": ["Kelvin": kelvin]]
    }

    private func mergeNauticalValues(_ kelvin: Double) -> [String:[String: Double]] {
        [:]
    }
}
