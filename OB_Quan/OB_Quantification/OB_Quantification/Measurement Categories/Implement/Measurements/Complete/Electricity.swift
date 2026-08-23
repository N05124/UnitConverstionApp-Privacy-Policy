//
//  Electricity.swift
//  OB_Quantification
//
//  Created by Arison on 11/28/25.
//

import Foundation

struct Electricity: UnitCategory {
    var name: String
    let currentPage = "Electricity"
    let status = "Active"
    let isExportable = true

    // MARK: - Unit Groups
    let metric = [
        // Current
        "Ampere", "Milliampere", "Microampere", "Kiloampere", "Megaampere",
        // Voltage
        "Volt", "Millivolt", "Microvolt", "Kilovolt", "Megavolt",
        // Resistance
        "Ohm", "Milliohm", "Kiloohm", "Megaohm",
        // Capacitance
        "Farad", "Millifarad", "Microfarad", "Nanofarad", "Picofarad",
        // Inductance
        "Henry", "Millihenry", "Microhenry", "Kilohenry"
    ]

    let imperial = [
        "Statampere", "Abampere", "Abvolt", "Abohm", "EMUOfCapacitance", "EMUOfInductance"
    ]

    let scientific = [
        "CoulombPerSecond", "TeslaAmpereMeter", "ElectronVoltPerSecond", "MegaCoulomb"
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
        } else if nautical.contains(unit) {
            return convertFromNautical(value, unit: unit)
        }
        return [:]
    }

    // MARK: - Conversion Helpers
    private func convertFromMetric(_ value: Double, unit: String) -> [String:[String: Double]] {
        var baseValue: Double = value

        switch unit {
        // Current
        case "Ampere": baseValue = value
        case "Milliampere": baseValue = value / 1000
        case "Microampere": baseValue = value / 1e6
        case "Kiloampere": baseValue = value * 1000
        case "Megaampere": baseValue = value * 1e6
        // Voltage
        case "Volt": baseValue = value
        case "Millivolt": baseValue = value / 1000
        case "Microvolt": baseValue = value / 1e6
        case "Kilovolt": baseValue = value * 1000
        case "Megavolt": baseValue = value * 1e6
        // Resistance
        case "Ohm": baseValue = value
        case "Milliohm": baseValue = value / 1000
        case "Kiloohm": baseValue = value * 1000
        case "Megaohm": baseValue = value * 1e6
        // Capacitance
        case "Farad": baseValue = value
        case "Millifarad": baseValue = value / 1000
        case "Microfarad": baseValue = value / 1e6
        case "Nanofarad": baseValue = value / 1e9
        case "Picofarad": baseValue = value / 1e12
        // Inductance
        case "Henry": baseValue = value
        case "Millihenry": baseValue = value / 1000
        case "Microhenry": baseValue = value / 1e6
        case "Kilohenry": baseValue = value * 1000
        default: baseValue = value
        }

        var result = mergeMetricValues(baseValue)
        result.merge(mergeImperialValues(baseValue)) { c,_ in c }
        result.merge(mergeScientificValues(baseValue)) { c,_ in c }
        result.merge(mergeNauticalValues(baseValue)) { c,_ in c }
        return result
    }

    private func convertFromImperial(_ value: Double, unit: String) -> [String:[String: Double]] {
        var baseValue: Double
        switch unit {
        case "Statampere": baseValue = value * 3.33564e-10 // esu current → A
        case "Abampere": baseValue = value * 10 // emu current → A
        case "Abvolt": baseValue = value * 1e-8 // emu voltage → V
        case "Abohm": baseValue = value * 1e-9 // emu resistance → Ω
        case "EMUOfCapacitance": baseValue = value * 1e9 // abfarad → F
        case "EMUOfInductance": baseValue = value * 1e-9 // abhenry → H
        default: baseValue = value
        }

        var result = mergeImperialValues(baseValue)
        result.merge(mergeMetricValues(baseValue)) { c,_ in c }
        result.merge(mergeScientificValues(baseValue)) { c,_ in c }
        result.merge(mergeNauticalValues(baseValue)) { c,_ in c }
        return result
    }

    private func convertFromScientific(_ value: Double, unit: String) -> [String:[String: Double]] {
        var baseValue: Double
        switch unit {
        case "CoulombPerSecond": baseValue = value
        case "TeslaAmpereMeter": baseValue = value
        case "ElectronVoltPerSecond": baseValue = value * 1.602e-19
        case "MegaCoulomb": baseValue = value * 1e6
        default: baseValue = value
        }

        var result = mergeScientificValues(baseValue)
        result.merge(mergeMetricValues(baseValue)) { c,_ in c }
        result.merge(mergeImperialValues(baseValue)) { c,_ in c }
        result.merge(mergeNauticalValues(baseValue)) { c,_ in c }
        return result
    }

    private func convertFromNautical(_ value: Double, unit: String) -> [String:[String: Double]] {
        return [:]
    }

    // MARK: - Merge Groups
    private func mergeMetricValues(_ value: Double) -> [String:[String: Double]] {
        return ["Metric": [
            "Ampere": value,
            "Milliampere": value * 1000,
            "Microampere": value * 1e6,
            "Kiloampere": value / 1000,
            "Megaampere": value / 1e6,
            "Volt": value,
            "Millivolt": value * 1000,
            "Microvolt": value * 1e6,
            "Kilovolt": value / 1000,
            "Megavolt": value / 1e6,
            "Ohm": value,
            "Milliohm": value * 1000,
            "Kiloohm": value / 1000,
            "Megaohm": value / 1e6,
            "Farad": value,
            "Millifarad": value * 1000,
            "Microfarad": value * 1e6,
            "Nanofarad": value * 1e9,
            "Picofarad": value * 1e12,
            "Henry": value,
            "Millihenry": value * 1000,
            "Microhenry": value * 1e6,
            "Kilohenry": value / 1000
        ]]
    }

    private func mergeImperialValues(_ value: Double) -> [String:[String: Double]] {
        return ["Imperial": [
            "Statampere": value / 3.33564e-10,
            "Abampere": value / 10,
            "Abvolt": value / 1e-8,
            "Abohm": value / 1e-9,
            "EMUOfCapacitance": value / 1e9,
            "EMUOfInductance": value / 1e-9
        ]]
    }

    private func mergeScientificValues(_ value: Double) -> [String:[String: Double]] {
        return ["Scientific": [
            "CoulombPerSecond": value,
            "TeslaAmpereMeter": value,
            "ElectronVoltPerSecond": value / 1.602e-19,
            "MegaCoulomb": value / 1e6
        ]]
    }

    private func mergeNauticalValues(_ value: Double) -> [String:[String: Double]] {
        return [:]
    }
}
