//
//  Electromagnetic.swift
//  OB_Quantification
//
//  Magnetic flux density (B-field). Voltage/current/etc. live in Electricity.swift;
// radiant flux overlaps Illumination / Power.
//

import Foundation

struct Electromagnetic: UnitCategory {
    var name: String
    let currentPage = "Electromagnetic"
    let status = "In Progress"
    let isExportable = true

    // Base = tesla
    let metric = [
        "Tesla", "Millitesla", "Microtesla", "Nanotesla"
    ]

    let imperial: [String] = []

    // 1 G = 1e-4 T (CGS)
    let scientific = [
        "Gauss", "Milligauss", "WeberPerSquareMeter" // Wb/m² ≡ T
    ]

    let nautical: [String] = []

    func convertedValues(value: Double, from unit: String) -> [String:[String: Double]] {
        if metric.contains(unit) {
            return convertFromMetric(value, unit: unit)
        } else if scientific.contains(unit) {
            return convertFromScientific(value, unit: unit)
        }
        return [:]
    }

    private func convertFromMetric(_ value: Double, unit: String) -> [String:[String: Double]] {
        let tesla: Double
        switch unit {
        case "Tesla": tesla = value
        case "Millitesla": tesla = value * 1e-3
        case "Microtesla": tesla = value * 1e-6
        case "Nanotesla": tesla = value * 1e-9
        default: tesla = value
        }
        var result = mergeMetricValues(tesla)
        result.merge(mergeScientificValues(tesla)) { c, _ in c }
        return result
    }

    private func convertFromScientific(_ value: Double, unit: String) -> [String:[String: Double]] {
        let tesla: Double
        switch unit {
        case "Gauss": tesla = value * 1e-4
        case "Milligauss": tesla = value * 1e-7
        case "WeberPerSquareMeter": tesla = value // ≡ T
        default: tesla = value
        }
        var result = mergeScientificValues(tesla)
        result.merge(mergeMetricValues(tesla)) { c, _ in c }
        return result
    }

    private func mergeMetricValues(_ tesla: Double) -> [String:[String: Double]] {
        [
            "Metric": [
                "Tesla": tesla,
                "Millitesla": tesla / 1e-3,
                "Microtesla": tesla / 1e-6,
                "Nanotesla": tesla / 1e-9
            ]
        ]
    }

    private func mergeScientificValues(_ tesla: Double) -> [String:[String: Double]] {
        [
            "Scientific": [
                "Gauss": tesla / 1e-4,
                "Milligauss": tesla / 1e-7,
                "WeberPerSquareMeter": tesla
            ]
        ]
    }
}
