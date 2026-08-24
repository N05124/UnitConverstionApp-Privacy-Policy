//
//  Force.swift
//  OB_Quantification
//
//  Created by Arison on 11/28/25.
//

import Foundation

struct Force: UnitCategory {
    var name: String
    let currentPage = "Force"
    let status = "Active"
    let isExportable = true

    // MARK: - Unit Groups
    let metric = [
        "Millinewton", "Centinewton", "Decinewton", "Newton", "Decanewton",
        "Hectonewton", "Kilonewton", "Meganewton", "Giganewton", "Teranewton",
        "Petanewton", "ExameterNewton", "Zettanewton", "Yottanewton"
    ]

    let imperial = [
        "OunceForce", "PoundForce", "StoneForce", "TonForce", "Kip", "LongTonForce"
    ]

    let scientific = [
        "Dyne", "GramForce", "KilogramForce", "MegagramForce",
        "PlanckForce", "AstronomicalForce", "SolarForce"
    ]

    let nautical = [
        "OunceForce", "PoundForce", "LongTonForce"
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
        let toNewton: Double
        switch unit {
        case "Millinewton": toNewton = value / 1000
        case "Centinewton": toNewton = value / 100
        case "Decinewton": toNewton = value / 10
        case "Newton": toNewton = value
        case "Decanewton": toNewton = value * 10
        case "Hectonewton": toNewton = value * 100
        case "Kilonewton": toNewton = value * 1_000
        case "Meganewton": toNewton = value * 1_000_000
        case "Giganewton": toNewton = value * 1e9
        case "Teranewton": toNewton = value * 1e12
        case "Petanewton": toNewton = value * 1e15
        case "ExameterNewton": toNewton = value * 1e18
        case "Zettanewton": toNewton = value * 1e21
        case "Yottanewton": toNewton = value * 1e24
        default: toNewton = value
        }

        var result = mergeMetricValues(toNewton)
        result.merge(mergeImperialValues(toNewton)) { c,_ in c }
        result.merge(mergeScientificValues(toNewton)) { c,_ in c }
        result.merge(mergeNauticalValues(toNewton)) { c,_ in c }
        return result
    }

    private func convertFromImperial(_ value: Double, unit: String) -> [String:[String: Double]] {
        let toNewton: Double
        switch unit {
        case "OunceForce": toNewton = value * (4.44822 / 16.0)
        case "PoundForce": toNewton = value * 4.44822
        case "StoneForce": toNewton = value * (14.0 * 4.44822)
        case "TonForce": toNewton = value * 8_896.44
        case "Kip": toNewton = value * 4_448.22
        case "LongTonForce": toNewton = value * 9_964.02
        default: toNewton = value
        }

        var result = mergeImperialValues(toNewton)
        result.merge(mergeMetricValues(toNewton)) { c,_ in c }
        result.merge(mergeScientificValues(toNewton)) { c,_ in c }
        result.merge(mergeNauticalValues(toNewton)) { c,_ in c }
        return result
    }

    private func convertFromScientific(_ value: Double, unit: String) -> [String:[String: Double]] {
        let toNewton: Double
        switch unit {
        case "Dyne": toNewton = value * 1e-5
        case "GramForce": toNewton = value * 0.00980665
        case "KilogramForce": toNewton = value * 9.80665
        case "MegagramForce": toNewton = value * 9_806.65
        case "PlanckForce": toNewton = value * 1.21027e44
        case "AstronomicalForce": toNewton = value * 1e20   // hypothetical cosmic-scale force
        case "SolarForce": toNewton = value * 3.5e22         // hypothetical solar-scale force
        default: toNewton = value
        }

        var result = mergeScientificValues(toNewton)
        result.merge(mergeMetricValues(toNewton)) { c,_ in c }
        result.merge(mergeImperialValues(toNewton)) { c,_ in c }
        result.merge(mergeNauticalValues(toNewton)) { c,_ in c }
        return result
    }

    private func convertFromNautical(_ value: Double, unit: String) -> [String:[String: Double]] {
        let toNewton: Double
        switch unit {
        case "OunceForce": toNewton = value * (4.44822 / 16.0)
        case "PoundForce": toNewton = value * 4.44822
        case "LongTonForce": toNewton = value * 9_964.02
        default: toNewton = value
        }

        var result = mergeNauticalValues(toNewton)
        result.merge(mergeMetricValues(toNewton)) { c,_ in c }
        result.merge(mergeImperialValues(toNewton)) { c,_ in c }
        result.merge(mergeScientificValues(toNewton)) { c,_ in c }
        return result
    }

    // MARK: - Merge Groups
    private func mergeMetricValues(_ value: Double) -> [String:[String: Double]] {
        return ["Metric": [
            "Millinewton": value / 0.001,
            "Centinewton": value / 0.01,
            "Decinewton": value / 0.1,
            "Newton": value,
            "Decanewton": value / 10,
            "Hectonewton": value / 100,
            "Kilonewton": value / 1_000,
            "Meganewton": value / 1_000_000,
            "Giganewton": value / 1e9,
            "Teranewton": value / 1e12,
            "Petanewton": value / 1e15,
            "ExameterNewton": value / 1e18,
            "Zettanewton": value / 1e21,
            "Yottanewton": value / 1e24
        ]]
    }

    private func mergeImperialValues(_ value: Double) -> [String:[String: Double]] {
        return ["Imperial": [
            "OunceForce": value / (4.44822 / 16.0),
            "PoundForce": value / 4.44822,
            "StoneForce": value / (14.0 * 4.44822),
            "TonForce": value / 8_896.44,
            "Kip": value / 4_448.22,
            "LongTonForce": value / 9_964.02
        ]]
    }

    private func mergeScientificValues(_ value: Double) -> [String:[String: Double]] {
        return ["Scientific": [
            "Dyne": value / 1e-5,
            "GramForce": value / 0.00980665,
            "KilogramForce": value / 9.80665,
            "MegagramForce": value / 9_806.65,
            "PlanckForce": value / 1.21027e44,
            "AstronomicalForce": value / 1e20,
            "SolarForce": value / 3.5e22
        ]]
    }

    private func mergeNauticalValues(_ value: Double) -> [String:[String: Double]] {
        return ["Nautical": [
            "OunceForce": value / (4.44822 / 16.0),
            "PoundForce": value / 4.44822,
            "LongTonForce": value / 9_964.02
        ]]
    }
}
