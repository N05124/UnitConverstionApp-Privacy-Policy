//
//  MetabolicRate.swift
//  OB_Quantification
//

import Foundation

struct MetabolicRate: UnitCategory {
    var name: String
    let currentPage = "Metabolic Rate"
    let status = "Active"
    let isExportable = true

    let metric = [
        "CaloriesPerMinute", "CaloriesPerHour", "KilojoulesPerMinute", "KilojoulesPerHour"
    ]

    let imperial: [String] = []

    let scientific: [String] = []

    let nautical: [String] = []

    // Same kcal→kJ factor as Energy.swift (food/kilocalorie convention: 1 Cal = 4.184 kJ)
    private static let kcalToKj = 4.184

    func convertedValues(value: Double, from unit: String) -> [String:[String: Double]] {
        if metric.contains(unit) {
            return convertFromMetric(value, unit: unit)
        }
        return [:]
    }

    // Base = CaloriesPerMinute
    private func convertFromMetric(_ value: Double, unit: String) -> [String:[String: Double]] {
        let calPerMin: Double
        switch unit {
        case "CaloriesPerMinute": calPerMin = value
        case "CaloriesPerHour": calPerMin = value / 60.0
        case "KilojoulesPerMinute": calPerMin = value / Self.kcalToKj
        case "KilojoulesPerHour": calPerMin = value / (60.0 * Self.kcalToKj)
        default: calPerMin = value
        }
        return mergeMetricValues(calPerMin)
    }

    private func mergeMetricValues(_ calPerMin: Double) -> [String:[String: Double]] {
        ["Metric": [
            "CaloriesPerMinute": calPerMin,
            "CaloriesPerHour": calPerMin * 60.0,
            "KilojoulesPerMinute": calPerMin * Self.kcalToKj,
            "KilojoulesPerHour": calPerMin * 60.0 * Self.kcalToKj
        ]]
    }
}
