//
//  AbsorbedDose.swift
//  OB_Quantification
//

import Foundation

struct AbsorbedDose: UnitCategory {
    var name: String
    let currentPage = "Absorbed Dose"
    let status = "Active"
    let isExportable = true

    let metric = [
        "Gray"
    ]

    let imperial: [String] = []

    let scientific = [
        "Rad"
    ]

    let nautical: [String] = []

    // 1 rad = 0.01 Gy (CGS → SI)
    private static let radToGray = 0.01

    func convertedValues(value: Double, from unit: String) -> [String:[String: Double]] {
        if metric.contains(unit) {
            return convertFromMetric(value, unit: unit)
        } else if scientific.contains(unit) {
            return convertFromScientific(value, unit: unit)
        }
        return [:]
    }

    private func convertFromMetric(_ value: Double, unit: String) -> [String:[String: Double]] {
        let gray: Double
        switch unit {
        case "Gray": gray = value
        default: gray = value
        }
        return mergeAll(gray)
    }

    private func convertFromScientific(_ value: Double, unit: String) -> [String:[String: Double]] {
        let gray: Double
        switch unit {
        case "Rad": gray = value * Self.radToGray
        default: gray = value
        }
        return mergeAll(gray)
    }

    private func mergeAll(_ gray: Double) -> [String:[String: Double]] {
        var result = mergeMetricValues(gray)
        result.merge(mergeScientificValues(gray)) { c, _ in c }
        return result
    }

    private func mergeMetricValues(_ gray: Double) -> [String:[String: Double]] {
        ["Metric": ["Gray": gray]]
    }

    private func mergeScientificValues(_ gray: Double) -> [String:[String: Double]] {
        ["Scientific": ["Rad": gray / Self.radToGray]]
    }
}
