//
//  DigitalStorage.swift
//  OB_Quantification
//

import Foundation

struct DigitalStorage: UnitCategory {
    var name: String
    let currentPage = "Digital Storage"
    let status = "Active"
    let isExportable = true

    // Decimal (SI) multiples — base 1000
    let metric = [
        "Bit", "Byte", "Kilobyte", "Megabyte", "Gigabyte", "Terabyte", "Petabyte"
    ]

    // Binary (IEC) multiples — base 1024
    let imperial = [
        "Kibibyte", "Mebibyte", "Gibibyte", "Tebibyte"
    ]

    let scientific: [String] = []

    let nautical: [String] = []

    func convertedValues(value: Double, from unit: String) -> [String:[String: Double]] {
        if metric.contains(unit) {
            return convertFromMetric(value, unit: unit)
        } else if imperial.contains(unit) {
            return convertFromImperial(value, unit: unit)
        }
        return [:]
    }

    // Base = bit
    private func convertFromMetric(_ value: Double, unit: String) -> [String:[String: Double]] {
        let toBits: Double
        switch unit {
        case "Bit": toBits = value
        case "Byte": toBits = value * 8
        case "Kilobyte": toBits = value * 8 * 1e3
        case "Megabyte": toBits = value * 8 * 1e6
        case "Gigabyte": toBits = value * 8 * 1e9
        case "Terabyte": toBits = value * 8 * 1e12
        case "Petabyte": toBits = value * 8 * 1e15
        default: toBits = value
        }
        var result = mergeMetricValues(toBits)
        result.merge(mergeImperialValues(toBits)) { c, _ in c }
        return result
    }

    private func convertFromImperial(_ value: Double, unit: String) -> [String:[String: Double]] {
        let toBits: Double
        switch unit {
        case "Kibibyte": toBits = value * 8 * 1024
        case "Mebibyte": toBits = value * 8 * 1024 * 1024
        case "Gibibyte": toBits = value * 8 * 1024 * 1024 * 1024
        case "Tebibyte": toBits = value * 8 * 1024 * 1024 * 1024 * 1024
        default: toBits = value
        }
        var result = mergeImperialValues(toBits)
        result.merge(mergeMetricValues(toBits)) { c, _ in c }
        return result
    }

    private func mergeMetricValues(_ bits: Double) -> [String:[String: Double]] {
        ["Metric": [
            "Bit": bits,
            "Byte": bits / 8,
            "Kilobyte": bits / (8 * 1e3),
            "Megabyte": bits / (8 * 1e6),
            "Gigabyte": bits / (8 * 1e9),
            "Terabyte": bits / (8 * 1e12),
            "Petabyte": bits / (8 * 1e15)
        ]]
    }

    private func mergeImperialValues(_ bits: Double) -> [String:[String: Double]] {
        ["Imperial": [
            "Kibibyte": bits / (8 * 1024),
            "Mebibyte": bits / (8 * 1024 * 1024),
            "Gibibyte": bits / (8 * 1024 * 1024 * 1024),
            "Tebibyte": bits / (8 * 1024 * 1024 * 1024 * 1024)
        ]]
    }
}
