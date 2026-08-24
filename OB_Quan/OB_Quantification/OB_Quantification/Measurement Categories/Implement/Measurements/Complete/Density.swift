//
//  Density.swift
//  OB_Quantification
//
//  Created by Arison on 11/28/25.
//

import Foundation

struct Density: UnitCategory {
    var name: String
    let currentPage = "Density"
    let status = "Active"
    let isExportable = true

    // MARK: - Unit Groups
    let metric = [
        "KilogramPerCubicMeter", "GramPerCubicCentimeter", "GramPerCubicMeter"
    ]

    let imperial = [
        "PoundPerCubicFoot", "PoundPerCubicInch"
    ]

    let scientific = [
        "KilogramPerLiter", "GramPerLiter"
    ]

    let nautical = [
        "SlugPerCubicFoot"
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
        let toKgPerM3: Double
        switch unit {
        case "KilogramPerCubicMeter": toKgPerM3 = value
        case "GramPerCubicCentimeter": toKgPerM3 = value * 1000
        case "GramPerCubicMeter": toKgPerM3 = value / 1000
        default: toKgPerM3 = value
        }

        var result = mergeMetricValues(toKgPerM3)
        result.merge(mergeImperialValues(toKgPerM3)) { c,_ in c }
        result.merge(mergeNauticalValues(toKgPerM3)) { c,_ in c }
        result.merge(mergeScientificValues(toKgPerM3)) { c,_ in c }
        return result
    }

    private func convertFromImperial(_ value: Double, unit: String) -> [String:[String: Double]] {
        let toKgPerM3: Double
        switch unit {
        case "PoundPerCubicFoot": toKgPerM3 = value * 16.0185
        case "PoundPerCubicInch": toKgPerM3 = value * 27679.9
        default: toKgPerM3 = value
        }

        var result = mergeImperialValues(toKgPerM3)
        result.merge(mergeMetricValues(toKgPerM3)) { c,_ in c }
        result.merge(mergeNauticalValues(toKgPerM3)) { c,_ in c }
        result.merge(mergeScientificValues(toKgPerM3)) { c,_ in c }
        return result
    }

    private func convertFromNautical(_ value: Double, unit: String) -> [String:[String: Double]] {
        let toKgPerM3: Double
        switch unit {
        case "SlugPerCubicFoot": toKgPerM3 = value * 515.3788
        default: toKgPerM3 = value
        }

        var result = mergeNauticalValues(toKgPerM3)
        result.merge(mergeMetricValues(toKgPerM3)) { c,_ in c }
        result.merge(mergeImperialValues(toKgPerM3)) { c,_ in c }
        result.merge(mergeScientificValues(toKgPerM3)) { c,_ in c }
        return result
    }

    private func convertFromScientific(_ value: Double, unit: String) -> [String:[String: Double]] {
        let toKgPerM3: Double
        switch unit {
        case "KilogramPerLiter": toKgPerM3 = value * 1000
        case "GramPerLiter": toKgPerM3 = value
        default: toKgPerM3 = value
        }

        var result = mergeScientificValues(toKgPerM3)
        result.merge(mergeMetricValues(toKgPerM3)) { c,_ in c }
        result.merge(mergeImperialValues(toKgPerM3)) { c,_ in c }
        result.merge(mergeNauticalValues(toKgPerM3)) { c,_ in c }
        return result
    }

    // MARK: - Merge Groups
    private func mergeMetricValues(_ value: Double) -> [String:[String: Double]] {
        return ["Metric": [
            "KilogramPerCubicMeter": value,
            "GramPerCubicCentimeter": value / 1000,
            "GramPerCubicMeter": value * 1000
        ]]
    }

    private func mergeImperialValues(_ value: Double) -> [String:[String: Double]] {
        return ["Imperial": [
            "PoundPerCubicFoot": value / 16.0185,
            "PoundPerCubicInch": value / 27679.9
        ]]
    }

    private func mergeNauticalValues(_ value: Double) -> [String:[String: Double]] {
        return ["Nautical": [
            "SlugPerCubicFoot": value / 515.3788
        ]]
    }

    private func mergeScientificValues(_ value: Double) -> [String:[String: Double]] {
        return ["Scientific": [
            "KilogramPerLiter": value / 1000,
            "GramPerLiter": value
        ]]
    }
}
