//
//  Speed.swift
//  OB_Quantification
//
//  Created by Arison on 11/28/25.
//

import Foundation

struct Speed: UnitCategory {
    var name: String
    let currentPage = "Speed"
    let status = "Active"
    let isExportable = true

    // MARK: - Unit Groups
    let metric = [
        "MillimeterPerSecond", "CentimeterPerSecond", "MeterPerSecond",
        "KilometerPerHour", "KilometerPerSecond"
    ]

    let imperial = [
        "InchPerSecond", "FootPerSecond", "YardPerSecond", "MilePerHour",
        "MilePerSecond"
    ]

    let scientific = [
        "SpeedOfSound", "SpeedOfLight"
    ]

    let nautical = [
        "Knot"
    ]

    // MARK: - Main Conversion Router
    func convertedValues(value: Double, from unit: String) -> [String:[String: Double]] {
        if metric.contains(unit) {
            return convertFromMetric(value, unit: unit)
        } else if imperial.contains(unit) {
            return convertFromImperial(value, unit: unit)
        } else if nautical.contains(unit) {
            return convertFromNautical(value, unit: unit)
        } else if scientific.contains(unit) {
            return convertFromScientific(value, unit: unit)
        }
        return [:]
    }

    // MARK: - Conversion Helpers
    private func convertFromMetric(_ value: Double, unit: String) -> [String:[String: Double]] {
        let toMPS: Double
        switch unit {
        case "MillimeterPerSecond": toMPS = value / 1000
        case "CentimeterPerSecond": toMPS = value / 100
        case "MeterPerSecond": toMPS = value
        case "KilometerPerHour": toMPS = value / 3.6
        case "KilometerPerSecond": toMPS = value * 1000
        default: toMPS = value
        }

        var result = mergeMetricValues(toMPS)
        result.merge(mergeImperialValues(toMPS)) { c,_ in c }
        result.merge(mergeNauticalValues(toMPS)) { c,_ in c }
        result.merge(mergeScientificValues(toMPS)) { c,_ in c }
        return result
    }

    private func convertFromImperial(_ value: Double, unit: String) -> [String:[String: Double]] {
        let toMPS: Double
        switch unit {
        case "InchPerSecond": toMPS = value * 0.0254
        case "FootPerSecond": toMPS = value * 0.3048
        case "YardPerSecond": toMPS = value * 0.9144
        case "MilePerHour": toMPS = value * 0.44704
        case "MilePerSecond": toMPS = value * 1609.344
        default: toMPS = value
        }

        var result = mergeImperialValues(toMPS)
        result.merge(mergeMetricValues(toMPS)) { c,_ in c }
        result.merge(mergeNauticalValues(toMPS)) { c,_ in c }
        result.merge(mergeScientificValues(toMPS)) { c,_ in c }
        return result
    }

    private func convertFromNautical(_ value: Double, unit: String) -> [String:[String: Double]] {
        let toMPS: Double
        switch unit {
        case "Knot": toMPS = value * 0.514444
        default: toMPS = value
        }

        var result = mergeNauticalValues(toMPS)
        result.merge(mergeMetricValues(toMPS)) { c,_ in c }
        result.merge(mergeImperialValues(toMPS)) { c,_ in c }
        result.merge(mergeScientificValues(toMPS)) { c,_ in c }
        return result
    }

    private func convertFromScientific(_ value: Double, unit: String) -> [String:[String: Double]] {
        let toMPS: Double
        switch unit {
        case "SpeedOfSound": toMPS = value * 343
        case "SpeedOfLight": toMPS = value * 299_792_458
        default: toMPS = value
        }

        var result = mergeScientificValues(toMPS)
        result.merge(mergeMetricValues(toMPS)) { c,_ in c }
        result.merge(mergeImperialValues(toMPS)) { c,_ in c }
        result.merge(mergeNauticalValues(toMPS)) { c,_ in c }
        return result
    }

    // MARK: - Merge Groups
    private func mergeMetricValues(_ value: Double) -> [String:[String: Double]] {
        return ["Metric": [
            "MillimeterPerSecond": value * 1000,
            "CentimeterPerSecond": value * 100,
            "MeterPerSecond": value,
            "KilometerPerHour": value * 3.6,
            "KilometerPerSecond": value / 1000
        ]]
    }

    private func mergeImperialValues(_ value: Double) -> [String:[String: Double]] {
        return ["Imperial": [
            "InchPerSecond": value / 0.0254,
            "FootPerSecond": value / 0.3048,
            "YardPerSecond": value / 0.9144,
            "MilePerHour": value / 0.44704,
            "MilePerSecond": value / 1609.344
        ]]
    }

    private func mergeNauticalValues(_ value: Double) -> [String:[String: Double]] {
        return ["Nautical": [
            "Knot": value / 0.514444
        ]]
    }

    private func mergeScientificValues(_ value: Double) -> [String:[String: Double]] {
        return ["Scientific": [
            "SpeedOfSound": value / 343,
            "SpeedOfLight": value / 299_792_458
        ]]
    }
}
