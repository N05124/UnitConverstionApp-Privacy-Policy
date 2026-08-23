//
//  Acoustic.swift
//  OB_Quantification
//
//  Sound pressure units. SPL uses the standard 20 µPa reference.
//

import Foundation

struct Acoustic: UnitCategory {
    var name: String
    let currentPage = "Acoustic"
    let status = "In Progress"
    let isExportable = true

    // Sound pressure (base = pascal)
    let metric = [
        "Pascal", "MicroPascal", "Millipascal"
    ]

    let imperial: [String] = []

    // dB SPL: L_p = 20 · log10(p / 20e-6 Pa)
    let scientific = [
        "DecibelSPL"
    ]

    let nautical: [String] = []

    // TODO: not a convertible unit without additional context —
    // requires reference calibration data: Speech Transmission Index (STI),
    // Mean Opinion Score, Clarity C50/C80, reverberation metrics beyond time.

    private let p0 = 20e-6 // Pa reference for dB SPL

    func convertedValues(value: Double, from unit: String) -> [String:[String: Double]] {
        if metric.contains(unit) {
            return convertFromMetric(value, unit: unit)
        } else if scientific.contains(unit) {
            return convertFromScientific(value, unit: unit)
        }
        return [:]
    }

    private func convertFromMetric(_ value: Double, unit: String) -> [String:[String: Double]] {
        let toPascal: Double
        switch unit {
        case "Pascal": toPascal = value
        case "MicroPascal": toPascal = value * 1e-6
        case "Millipascal": toPascal = value * 1e-3
        default: toPascal = value
        }
        var result = mergeMetricValues(toPascal)
        result.merge(mergeScientificValues(toPascal)) { c, _ in c }
        return result
    }

    private func convertFromScientific(_ value: Double, unit: String) -> [String:[String: Double]] {
        let toPascal: Double
        switch unit {
        case "DecibelSPL":
            // p = p0 · 10^(L/20)
            toPascal = p0 * pow(10.0, value / 20.0)
        default:
            toPascal = value
        }
        var result = mergeScientificValues(toPascal)
        result.merge(mergeMetricValues(toPascal)) { c, _ in c }
        return result
    }

    private func mergeMetricValues(_ pascals: Double) -> [String:[String: Double]] {
        [
            "Metric": [
                "Pascal": pascals,
                "MicroPascal": pascals / 1e-6,
                "Millipascal": pascals / 1e-3
            ]
        ]
    }

    private func mergeScientificValues(_ pascals: Double) -> [String:[String: Double]] {
        let db: Double
        if pascals > 0 {
            db = 20.0 * log10(pascals / p0)
        } else {
            db = -Double.infinity
        }
        return [
            "Scientific": [
                "DecibelSPL": db
            ]
        ]
    }
}
