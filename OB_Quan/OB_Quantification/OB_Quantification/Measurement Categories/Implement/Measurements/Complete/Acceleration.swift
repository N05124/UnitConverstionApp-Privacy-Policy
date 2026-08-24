//
//  Acceleration.swift
//  OB_Quantification
//
//  Created by Arison on 11/28/25.
//

import Foundation

struct Acceleration: UnitCategory {
    var name: String
    let currentPage = "Acceleration"
    let status = "Active"
    let isExportable = true

    // MARK: - Unit Groups
    let metric = [
        "MillimeterPerSecondSquared", "CentimeterPerSecondSquared", "MeterPerSecondSquared",
        "KilometerPerSecondSquared"
    ]

    let imperial = [
        "InchPerSecondSquared", "FootPerSecondSquared", "YardPerSecondSquared"
    ]

    let scientific = [
        "StandardGravity", "Gal"
    ]
    
    let nautical: [String] = []

    // MARK: - Main Conversion Router
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

    // MARK: - Conversion Helpers
    private func convertFromMetric(_ value: Double, unit: String) -> [String:[String: Double]] {
        let toMPS2: Double
        switch unit {
        case "MillimeterPerSecondSquared": toMPS2 = value / 1000
        case "CentimeterPerSecondSquared": toMPS2 = value / 100
        case "MeterPerSecondSquared": toMPS2 = value
        case "KilometerPerSecondSquared": toMPS2 = value * 1000
        default: toMPS2 = value
        }

        var result = mergeMetricValues(toMPS2)
        result.merge(mergeImperialValues(toMPS2)) { c,_ in c }
        result.merge(mergeScientificValues(toMPS2)) { c,_ in c }
        return result
    }

    private func convertFromImperial(_ value: Double, unit: String) -> [String:[String: Double]] {
        let toMPS2: Double
        switch unit {
        case "InchPerSecondSquared": toMPS2 = value * 0.0254
        case "FootPerSecondSquared": toMPS2 = value * 0.3048
        case "YardPerSecondSquared": toMPS2 = value * 0.9144
        default: toMPS2 = value
        }

        var result = mergeImperialValues(toMPS2)
        result.merge(mergeMetricValues(toMPS2)) { c,_ in c }
        result.merge(mergeScientificValues(toMPS2)) { c,_ in c }
        return result
    }

    private func convertFromScientific(_ value: Double, unit: String) -> [String:[String: Double]] {
        let toMPS2: Double
        switch unit {
        case "StandardGravity": toMPS2 = value * 9.80665
        case "Gal": toMPS2 = value * 0.01
        default: toMPS2 = value
        }

        var result = mergeScientificValues(toMPS2)
        result.merge(mergeMetricValues(toMPS2)) { c,_ in c }
        result.merge(mergeImperialValues(toMPS2)) { c,_ in c }
        return result
    }

    // MARK: - Merge Groups
    private func mergeMetricValues(_ value: Double) -> [String:[String: Double]] {
        return ["Metric": [
            "MillimeterPerSecondSquared": value * 1000,
            "CentimeterPerSecondSquared": value * 100,
            "MeterPerSecondSquared": value,
            "KilometerPerSecondSquared": value / 1000
        ]]
    }

    private func mergeImperialValues(_ value: Double) -> [String:[String: Double]] {
        return ["Imperial": [
            "InchPerSecondSquared": value / 0.0254,
            "FootPerSecondSquared": value / 0.3048,
            "YardPerSecondSquared": value / 0.9144
        ]]
    }

    private func mergeScientificValues(_ value: Double) -> [String:[String: Double]] {
        return ["Scientific": [
            "StandardGravity": value / 9.80665,
            "Gal": value / 0.01
        ]]
    }
}
