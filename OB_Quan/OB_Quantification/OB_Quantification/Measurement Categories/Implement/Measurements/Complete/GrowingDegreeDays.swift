//
//  GrowingDegreeDays.swift
//  OB_Quantification
//

import Foundation

struct GrowingDegreeDays: UnitCategory {
    var name: String
    let currentPage = "Growing Degree Days"
    let status = "Active"
    let isExportable = true

    let metric = [
        "GrowingDegreeDayCelsius"
    ]

    let imperial = [
        "GrowingDegreeDayFahrenheit"
    ]

    let scientific: [String] = []

    let nautical: [String] = []

    // GDD is an accumulated *temperature difference* above a baseline (commonly
    // 10 °C / 50 °F in agriculture — a convention, not a universal constant).
    // Converting a difference uses only the ×1.8 scale factor; the +32/−32
    // absolute-temperature offsets cancel and must NOT be applied here.

    func convertedValues(value: Double, from unit: String) -> [String:[String: Double]] {
        if metric.contains(unit) {
            return convertFromMetric(value, unit: unit)
        } else if imperial.contains(unit) {
            return convertFromImperial(value, unit: unit)
        }
        return [:]
    }

    // Base = GrowingDegreeDayCelsius
    private func convertFromMetric(_ value: Double, unit: String) -> [String:[String: Double]] {
        let gddC: Double
        switch unit {
        case "GrowingDegreeDayCelsius": gddC = value
        default: gddC = value
        }
        return mergeAll(gddC)
    }

    private func convertFromImperial(_ value: Double, unit: String) -> [String:[String: Double]] {
        let gddC: Double
        switch unit {
        case "GrowingDegreeDayFahrenheit": gddC = value / 1.8
        default: gddC = value
        }
        return mergeAll(gddC)
    }

    private func mergeAll(_ gddC: Double) -> [String:[String: Double]] {
        var result = mergeMetricValues(gddC)
        result.merge(mergeImperialValues(gddC)) { c, _ in c }
        return result
    }

    private func mergeMetricValues(_ gddC: Double) -> [String:[String: Double]] {
        ["Metric": ["GrowingDegreeDayCelsius": gddC]]
    }

    private func mergeImperialValues(_ gddC: Double) -> [String:[String: Double]] {
        ["Imperial": ["GrowingDegreeDayFahrenheit": gddC * 1.8]]
    }
}
