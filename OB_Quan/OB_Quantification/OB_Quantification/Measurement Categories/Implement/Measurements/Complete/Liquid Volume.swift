//
//  Liquid Volume.swift
//  OB_Quantification
//
//  Created by Arison on 11/26/25.
//

import Foundation

struct LiquidVolume: UnitCategory {
    var name: String
    let currentPage = "Liquid Volume"
    let status = "Active"
    let isExportable = true

    // MARK: - Unit Groups
    let metric = [
        "Milliliter", "Centiliter", "Deciliter", "Liter", "Decaliter",
        "Hectoliter", "Kiloliter"
    ]

    let imperial = [
        "Teaspoon", "Tablespoon", "FluidOunce", "Cup", "Pint",
        "Quart", "Gallon"
    ]

    let scientific = [
        "Microliter", "Nanoliter", "Milliliter", "Liter", "CubicMeter"
    ]

    let nautical = [
        "Barrel", "OilBarrel", "Hogshead", "ImperialGallon"
    ]

    // MARK: - Dynamic Conversion Logic
    func convertedValues(value: Double, from unit: String) -> [String:[String: Double]] {
        if metric.contains(unit) {
            return convertFromMetric(value, unit: unit)
        } else if imperial.contains(unit) {
            return convertFromImperial(value, unit: unit)
        } else if scientific.contains(unit) {
            return convertFromScientific(value, unit: unit)
        } else if nautical.contains(unit) {
            return convertFromNautical(value, unit: unit)
        } else {
            return [:]
        }
    }

    // MARK: - Conversion Helpers
    private func convertFromMetric(_ value: Double, unit: String) -> [String:[String: Double]] {
        let toLiters: Double
        switch unit {
        case "Milliliter": toLiters = value / 1000
        case "Centiliter": toLiters = value / 100
        case "Deciliter": toLiters = value / 10
        case "Liter": toLiters = value
        case "Decaliter": toLiters = value * 10
        case "Hectoliter": toLiters = value * 100
        case "Kiloliter": toLiters = value * 1000
        default: toLiters = value
        }

        var result = mergeMetricValues(toLiters)
        result.merge(mergeImperialValues(toLiters)) { current, _ in current }
        result.merge(mergeNauticalValues(toLiters)) { current, _ in current }
        result.merge(mergeScientificValues(toLiters)) { current, _ in current }
        return result
    }

    private func convertFromImperial(_ value: Double, unit: String) -> [String:[String: Double]] {
        let toLiters: Double
        switch unit {
        case "Teaspoon": toLiters = value * 0.00492892
        case "Tablespoon": toLiters = value * 0.0147868
        case "FluidOunce": toLiters = value * 0.0295735
        case "Cup": toLiters = value * 0.236588
        case "Pint": toLiters = value * 0.473176
        case "Quart": toLiters = value * 0.946353
        case "Gallon": toLiters = value * 3.78541
        default: toLiters = value
        }

        var result = mergeImperialValues(toLiters)
        result.merge(mergeMetricValues(toLiters)) { current, _ in current }
        result.merge(mergeNauticalValues(toLiters)) { current, _ in current }
        result.merge(mergeScientificValues(toLiters)) { current, _ in current }
        return result
    }

    private func convertFromScientific(_ value: Double, unit: String) -> [String:[String: Double]] {
        let toLiters: Double
        switch unit {
        case "Microliter": toLiters = value / 1e6
        case "Nanoliter": toLiters = value / 1e9
        case "Milliliter": toLiters = value / 1000
        case "Liter": toLiters = value
        case "CubicMeter": toLiters = value * 1000
        default: toLiters = value
        }

        var result = mergeScientificValues(toLiters)
        result.merge(mergeMetricValues(toLiters)) { current, _ in current }
        result.merge(mergeImperialValues(toLiters)) { current, _ in current }
        result.merge(mergeNauticalValues(toLiters)) { current, _ in current }
        return result
    }

    private func convertFromNautical(_ value: Double, unit: String) -> [String:[String: Double]] {
        let toLiters: Double
        switch unit {
        case "Barrel": toLiters = value * 158.987
        case "OilBarrel": toLiters = value * 158.987
        case "Hogshead": toLiters = value * 238.481
        case "ImperialGallon": toLiters = value * 4.54609
        default: toLiters = value
        }

        var result = mergeNauticalValues(toLiters)
        result.merge(mergeMetricValues(toLiters)) { current, _ in current }
        result.merge(mergeImperialValues(toLiters)) { current, _ in current }
        result.merge(mergeScientificValues(toLiters)) { current, _ in current }
        return result
    }

    // MARK: - Mergeable Dictionaries
    private func mergeMetricValues(_ value: Double) -> [String:[String: Double]] {
        ["Metric": [
            "Milliliter": value * 1000,
            "Centiliter": value * 100,
            "Deciliter": value * 10,
            "Liter": value,
            "Decaliter": value / 10,
            "Hectoliter": value / 100,
            "Kiloliter": value / 1000
        ]]
    }

    private func mergeImperialValues(_ value: Double) -> [String:[String: Double]] {
        ["Imperial": [
            "Teaspoon": value / 0.00492892,
            "Tablespoon": value / 0.0147868,
            "FluidOunce": value / 0.0295735,
            "Cup": value / 0.236588,
            "Pint": value / 0.473176,
            "Quart": value / 0.946353,
            "Gallon": value / 3.78541
        ]]
    }

    private func mergeScientificValues(_ value: Double) -> [String:[String: Double]] {
        ["Scientific": [
            "Microliter": value * 1e6,
            "Nanoliter": value * 1e9,
            "Milliliter": value * 1000,
            "Liter": value,
            "CubicMeter": value / 1000
        ]]
    }

    private func mergeNauticalValues(_ value: Double) -> [String:[String: Double]] {
        ["Nautical": [
            "Barrel": value / 158.987,
            "OilBarrel": value / 158.987,
            "Hogshead": value / 238.481,
            "ImperialGallon": value / 4.54609
        ]]
    }
}
