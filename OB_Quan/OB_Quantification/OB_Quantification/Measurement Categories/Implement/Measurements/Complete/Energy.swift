//
//  Energy.swift
//  OB_Quantification
//
//  Created by Arison on 11/28/25.
//

import Foundation

struct Energy: UnitCategory {
    var name: String
    let currentPage = "Energy"
    let status = "Active"
    let isExportable = true

    // MARK: - Unit Groups
    let metric = [
        "Joule", "Kilojoule", "Calorie", "Kilocalorie", "ElectronVolt"
    ]

    let imperial = [
        "BritishThermalUnit", "FootPound", "InchPound"
    ]

    let scientific = [
        "Erg", "PlanckEnergy", "MegaElectronVolt", "GigaElectronVolt"
    ]

    let nautical = [
        "TonneTNT"
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
        let toJoule: Double
        switch unit {
        case "Joule": toJoule = value
        case "Kilojoule": toJoule = value * 1000
        case "Calorie": toJoule = value * 4.184
        case "Kilocalorie": toJoule = value * 4184
        case "ElectronVolt": toJoule = value * 1.602e-19
        default: toJoule = value
        }

        var result = mergeMetricValues(toJoule)
        result.merge(mergeImperialValues(toJoule)) { c,_ in c }
        result.merge(mergeScientificValues(toJoule)) { c,_ in c }
        result.merge(mergeNauticalValues(toJoule)) { c,_ in c }
        return result
    }

    private func convertFromImperial(_ value: Double, unit: String) -> [String:[String: Double]] {
        let toJoule: Double
        switch unit {
        case "BritishThermalUnit": toJoule = value * 1055.06
        case "FootPound": toJoule = value * 1.35582
        case "InchPound": toJoule = value * 0.1129848
        default: toJoule = value
        }

        var result = mergeImperialValues(toJoule)
        result.merge(mergeMetricValues(toJoule)) { c,_ in c }
        result.merge(mergeScientificValues(toJoule)) { c,_ in c }
        result.merge(mergeNauticalValues(toJoule)) { c,_ in c }
        return result
    }

    private func convertFromScientific(_ value: Double, unit: String) -> [String:[String: Double]] {
        let toJoule: Double
        switch unit {
        case "Erg": toJoule = value * 1e-7
        case "PlanckEnergy": toJoule = value * 1.956e9
        case "MegaElectronVolt": toJoule = value * 1.602e-13
        case "GigaElectronVolt": toJoule = value * 1.602e-10
        default: toJoule = value
        }

        var result = mergeScientificValues(toJoule)
        result.merge(mergeMetricValues(toJoule)) { c,_ in c }
        result.merge(mergeImperialValues(toJoule)) { c,_ in c }
        result.merge(mergeNauticalValues(toJoule)) { c,_ in c }
        return result
    }

    private func convertFromNautical(_ value: Double, unit: String) -> [String:[String: Double]] {
        let toJoule: Double
        switch unit {
        case "TonneTNT": toJoule = value * 4.184e9
        default: toJoule = value
        }

        var result = mergeNauticalValues(toJoule)
        result.merge(mergeMetricValues(toJoule)) { c,_ in c }
        result.merge(mergeImperialValues(toJoule)) { c,_ in c }
        result.merge(mergeScientificValues(toJoule)) { c,_ in c }
        return result
    }

    // MARK: - Merge Groups
    private func mergeMetricValues(_ value: Double) -> [String:[String: Double]] {
        return ["Metric": [
            "Joule": value,
            "Kilojoule": value / 1000,
            "Calorie": value / 4.184,
            "Kilocalorie": value / 4184,
            "ElectronVolt": value / 1.602e-19
        ]]
    }

    private func mergeImperialValues(_ value: Double) -> [String:[String: Double]] {
        return ["Imperial": [
            "BritishThermalUnit": value / 1055.06,
            "FootPound": value / 1.35582,
            "InchPound": value / 0.1129848
        ]]
    }

    private func mergeScientificValues(_ value: Double) -> [String:[String: Double]] {
        return ["Scientific": [
            "Erg": value / 1e-7,
            "PlanckEnergy": value / 1.956e9,
            "MegaElectronVolt": value / 1.602e-13,
            "GigaElectronVolt": value / 1.602e-10
        ]]
    }

    private func mergeNauticalValues(_ value: Double) -> [String:[String: Double]] {
        return ["Nautical": [
            "TonneTNT": value / 4.184e9
        ]]
    }
}
