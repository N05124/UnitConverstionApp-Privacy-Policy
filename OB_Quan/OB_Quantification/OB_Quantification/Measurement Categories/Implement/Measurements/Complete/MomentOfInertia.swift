//
//  MomentOfInertia.swift
//  OB_Quantification
//

import Foundation

struct MomentOfInertia: UnitCategory {
    var name: String
    let currentPage = "Moment Of Inertia"
    let status = "Active"
    let isExportable = true

    let metric = [
        "KilogramMeterSquared"
    ]

    let imperial = [
        "PoundFootSquared"
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

    // 1 lb·ft² = 0.042140110093805 kg·m² (lb × ft²)
    private static let lbFt2ToKgM2 = 0.45359237 * 0.3048 * 0.3048

    private func convertFromMetric(_ value: Double, unit: String) -> [String:[String: Double]] {
        let kgm2: Double
        switch unit {
        case "KilogramMeterSquared": kgm2 = value
        default: kgm2 = value
        }
        return mergeAll(kgm2)
    }

    private func convertFromImperial(_ value: Double, unit: String) -> [String:[String: Double]] {
        let kgm2: Double
        switch unit {
        case "PoundFootSquared": kgm2 = value * Self.lbFt2ToKgM2
        default: kgm2 = value
        }
        return mergeAll(kgm2)
    }

    private func mergeAll(_ kgm2: Double) -> [String:[String: Double]] {
        var result = mergeMetricValues(kgm2)
        result.merge(mergeImperialValues(kgm2)) { c, _ in c }
        return result
    }

    private func mergeMetricValues(_ kgm2: Double) -> [String:[String: Double]] {
        ["Metric": ["KilogramMeterSquared": kgm2]]
    }

    private func mergeImperialValues(_ kgm2: Double) -> [String:[String: Double]] {
        ["Imperial": ["PoundFootSquared": kgm2 / Self.lbFt2ToKgM2]]
    }
}
