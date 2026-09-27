//
//  HeartRate.swift
//  OB_Quantification
//

import Foundation

struct HeartRate: UnitCategory {
    var name: String
    let currentPage = "Heart Rate"
    let status = "Active"
    let isExportable = true

    let metric = [
        "BeatsPerMinute"
    ]

    let imperial: [String] = []

    let scientific: [String] = []

    let nautical: [String] = []

    func convertedValues(value: Double, from unit: String) -> [String:[String: Double]] {
        if metric.contains(unit) {
            return convertFromMetric(value, unit: unit)
        }
        return [:]
    }

    private func convertFromMetric(_ value: Double, unit: String) -> [String:[String: Double]] {
        let bpm: Double
        switch unit {
        case "BeatsPerMinute": bpm = value
        default: bpm = value
        }
        return mergeMetricValues(bpm)
    }

    private func mergeMetricValues(_ bpm: Double) -> [String:[String: Double]] {
        ["Metric": ["BeatsPerMinute": bpm]]
    }
}
