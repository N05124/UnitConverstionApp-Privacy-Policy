//
//  Saturation.swift
//  OB_Quantification
//
//  Created by Arison on 11/28/25.
//

import Foundation
//
//  Saturation.swift
//  OB_Quantification
//
//  Created by Arison on 11/28/25.
//

import Foundation

struct Saturation: UnitCategory {
    var name: String
    let currentPage = "Saturation"
    let status = "Active"
    let isExportable = true

    // MARK: - Unit Groups
    let metric = [
        "Percent", "Fraction"
    ]

    let imperial: [String] = [
        
    ]

    let scientific = [
        "MolPerLiter", "MillimolPerLiter"
    ]

    let nautical: [String] = [
        
    ]

    // MARK: - Main Conversion Router
    func convertedValues(value: Double, from unit: String) -> [String:[String: Double]] {
        if metric.contains(unit) {
            return convertFromMetric(value, unit: unit)
        } else if imperial.contains(unit) {
            return convertFromImperial(value, unit: unit)
        } else if scientific.contains(unit) {
            return convertFromScientific(value, unit: unit)
        } else if nautical.contains(unit) {
            return convertFromNautical(value, unit: unit)
        }
        return [:]
    }

    // MARK: - Conversion Helpers
    private func convertFromMetric(_ value: Double, unit: String) -> [String:[String: Double]] {
        let toPercent: Double
        switch unit {
        case "Percent": toPercent = value
        case "Fraction": toPercent = value * 100
        default: toPercent = value
        }

        var result = mergeMetricValues(toPercent)
        result.merge(mergeImperialValues(toPercent)) { c,_ in c }
        result.merge(mergeScientificValues(toPercent)) { c,_ in c }
        result.merge(mergeNauticalValues(toPercent)) { c,_ in c }
        return result
    }

    private func convertFromImperial(_ value: Double, unit: String) -> [String:[String: Double]] {
        return [:] // No imperial units defined
    }

    private func convertFromScientific(_ value: Double, unit: String) -> [String:[String: Double]] {
        let toPercent: Double
        switch unit {
        case "MolPerLiter": toPercent = value * 1000 // Example conversion logic
        case "MillimolPerLiter": toPercent = value // Example conversion logic
        default: toPercent = value
        }

        var result = mergeScientificValues(toPercent)
        result.merge(mergeMetricValues(toPercent)) { c,_ in c }
        result.merge(mergeImperialValues(toPercent)) { c,_ in c }
        result.merge(mergeNauticalValues(toPercent)) { c,_ in c }
        return result
    }

    private func convertFromNautical(_ value: Double, unit: String) -> [String:[String: Double]] {
        return [:]
    }

    // MARK: - Merge Groups
    private func mergeMetricValues(_ value: Double) -> [String:[String: Double]] {
        return ["Metric": [
            "Percent": value,
            "Fraction": value / 100
        ]]
    }

    private func mergeImperialValues(_ value: Double) -> [String:[String: Double]] {
        return [:]
    }

    private func mergeScientificValues(_ value: Double) -> [String:[String: Double]] {
        return ["Scientific": [
            "MolPerLiter": value / 1000,
            "MillimolPerLiter": value
        ]]
    }

    private func mergeNauticalValues(_ value: Double) -> [String:[String: Double]] {
        return [:]
    }
}
