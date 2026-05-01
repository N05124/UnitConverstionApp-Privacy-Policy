//
//  Pressure.swift
//  OB_Quantification
//
//  Created by Arison on 11/28/25.
//

import Foundation
//
//  Pressure.swift
//  OB_Quantification
//
//  Created by Arison on 11/28/25.
//

import Foundation

struct Pressure: UnitCategory {
    var name: String
    let currentPage = "Pressure"
    let status = "Active"
    let isExportable = true

    // MARK: - Unit Groups
    let metric = [
        "Pascal", "Kilopascal", "Megapascal", "Bar", "Millibar"
    ]

    let imperial = [
        "Psi", "PoundPerSquareInch", "InchOfMercury", "FootOfWater"
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
        let toPascal: Double
        switch unit {
        case "Pascal": toPascal = value
        case "Kilopascal": toPascal = value * 1e3
        case "Megapascal": toPascal = value * 1e6
        case "Bar": toPascal = value * 1e5
        case "Millibar": toPascal = value * 100
        default: toPascal = value
        }

        var result = mergeMetricValues(toPascal)
        result.merge(mergeImperialValues(toPascal)) { c,_ in c }
        result.merge(mergeScientificValues(toPascal)) { c,_ in c }
        result.merge(mergeNauticalValues(toPascal)) { c,_ in c }
        return result
    }

    private func convertFromImperial(_ value: Double, unit: String) -> [String:[String: Double]] {
        let toPascal: Double
        switch unit {
        case "Psi": toPascal = value * 6894.76
        case "PoundPerSquareInch": toPascal = value * 6894.76
        case "InchOfMercury": toPascal = value * 3386.39
        case "FootOfWater": toPascal = value * 2989.07
        default: toPascal = value
        }

        var result = mergeImperialValues(toPascal)
        result.merge(mergeMetricValues(toPascal)) { c,_ in c }
        result.merge(mergeScientificValues(toPascal)) { c,_ in c }
        result.merge(mergeNauticalValues(toPascal)) { c,_ in c }
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
            "Pascal": value,
            "Kilopascal": value / 1e3,
            "Megapascal": value / 1e6,
            "Bar": value / 1e5,
            "Millibar": value / 100
        ]]
    }

    private func mergeImperialValues(_ value: Double) -> [String:[String: Double]] {
        return ["Imperial": [
            "Psi": value / 6894.76,
            "PoundPerSquareInch": value / 6894.76,
            "InchOfMercury": value / 3386.39,
            "FootOfWater": value / 2989.07
        ]]
    }

    private func mergeScientificValues(_ value: Double) -> [String:[String: Double]] {
        return [:]
    }

    private func mergeNauticalValues(_ value: Double) -> [String:[String: Double]] {
        return [:]
    }
}
