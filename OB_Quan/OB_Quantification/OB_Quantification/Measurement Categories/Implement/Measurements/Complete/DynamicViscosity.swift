//
//  DynamicViscosity.swift
//  OB_Quantification
//

import Foundation

struct DynamicViscosity: UnitCategory {
    var name: String
    let currentPage = "Dynamic Viscosity"
    let status = "Active"
    let isExportable = true

    let metric = [
        "PascalSecond", "MillipascalSecond"
    ]

    let imperial = [
        "Poise", "Centipoise"
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

    // Base = Pa·s; 1 P (poise) = 0.1 Pa·s; 1 cP = 1 mPa·s
    private func convertFromMetric(_ value: Double, unit: String) -> [String:[String: Double]] {
        let pas: Double
        switch unit {
        case "PascalSecond": pas = value
        case "MillipascalSecond": pas = value * 1e-3
        default: pas = value
        }
        return mergeAll(pas)
    }

    private func convertFromImperial(_ value: Double, unit: String) -> [String:[String: Double]] {
        let pas: Double
        switch unit {
        case "Poise": pas = value * 0.1
        case "Centipoise": pas = value * 1e-3
        default: pas = value
        }
        return mergeAll(pas)
    }

    private func mergeAll(_ pas: Double) -> [String:[String: Double]] {
        var result = mergeMetricValues(pas)
        result.merge(mergeImperialValues(pas)) { c, _ in c }
        return result
    }

    private func mergeMetricValues(_ pas: Double) -> [String:[String: Double]] {
        ["Metric": [
            "PascalSecond": pas,
            "MillipascalSecond": pas / 1e-3
        ]]
    }

    private func mergeImperialValues(_ pas: Double) -> [String:[String: Double]] {
        ["Imperial": [
            "Poise": pas / 0.1,
            "Centipoise": pas / 1e-3
        ]]
    }
}
