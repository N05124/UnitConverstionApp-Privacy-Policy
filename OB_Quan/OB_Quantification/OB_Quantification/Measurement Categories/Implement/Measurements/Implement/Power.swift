//
//  Power.swift
//  OB_Quantification
//
//  Created by Arison on 11/28/25.
//

import Foundation

struct Power: UnitCategory {
    var name: String
    let currentPage = "Power"
    let status = "Active"
    let isExportable = true

    // MARK: - Unit Groups
    let metric = [
        "Watt", "Kilowatt", "Megawatt", "Gigawatt"
    ]

    let imperial = [
        "Horsepower"
    ]

    let scientific: [String] = [
        
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
        let toWatt: Double
        switch unit {
        case "Watt": toWatt = value
        case "Kilowatt": toWatt = value * 1000
        case "Megawatt": toWatt = value * 1e6
        case "Gigawatt": toWatt = value * 1e9
        default: toWatt = value
        }

        var result = mergeMetricValues(toWatt)
        result.merge(mergeImperialValues(toWatt)) { c,_ in c }
        result.merge(mergeScientificValues(toWatt)) { c,_ in c }
        result.merge(mergeNauticalValues(toWatt)) { c,_ in c }
        return result
    }

    private func convertFromImperial(_ value: Double, unit: String) -> [String:[String: Double]] {
        let toWatt: Double
        switch unit {
        case "Horsepower": toWatt = value * 745.7
        default: toWatt = value
        }

        var result = mergeImperialValues(toWatt)
        result.merge(mergeMetricValues(toWatt)) { c,_ in c }
        result.merge(mergeScientificValues(toWatt)) { c,_ in c }
        result.merge(mergeNauticalValues(toWatt)) { c,_ in c }
        return result
    }

    private func convertFromScientific(_ value: Double, unit: String) -> [String:[String: Double]] {
        return [:] // No scientific units defined
    }

    private func convertFromNautical(_ value: Double, unit: String) -> [String:[String: Double]] {
        return [:] // No nautical units defined
    }

    // MARK: - Merge Groups
    private func mergeMetricValues(_ value: Double) -> [String:[String: Double]] {
        return ["Metric": [
            "Watt": value,
            "Kilowatt": value / 1000,
            "Megawatt": value / 1e6,
            "Gigawatt": value / 1e9
        ]]
    }

    private func mergeImperialValues(_ value: Double) -> [String:[String: Double]] {
        return ["Imperial": [
            "Horsepower": value / 745.7
        ]]
    }

    private func mergeScientificValues(_ value: Double) -> [String:[String: Double]] {
        return [:]
    }

    private func mergeNauticalValues(_ value: Double) -> [String:[String: Double]] {
        return [:]
    }
}
//
//  Power.swift
//  OB_Quantification
//
//  Created by Arison on 11/28/25.
//

import Foundation
