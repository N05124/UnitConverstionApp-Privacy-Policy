//
//  DataTransferRate.swift
//  OB_Quantification
//

import Foundation

struct DataTransferRate: UnitCategory {
    var name: String
    let currentPage = "Data Transfer"
    let status = "Active"
    let isExportable = true

    let metric = [
        "BitPerSecond", "KilobitPerSecond", "MegabitPerSecond", "GigabitPerSecond",
        "BytePerSecond", "KilobytePerSecond", "MegabytePerSecond"
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

    // Base = bit/s (decimal kilo = 1000)
    private func convertFromMetric(_ value: Double, unit: String) -> [String:[String: Double]] {
        let bps: Double
        switch unit {
        case "BitPerSecond": bps = value
        case "KilobitPerSecond": bps = value * 1e3
        case "MegabitPerSecond": bps = value * 1e6
        case "GigabitPerSecond": bps = value * 1e9
        case "BytePerSecond": bps = value * 8
        case "KilobytePerSecond": bps = value * 8 * 1e3
        case "MegabytePerSecond": bps = value * 8 * 1e6
        default: bps = value
        }
        return mergeMetricValues(bps)
    }

    private func mergeMetricValues(_ bps: Double) -> [String:[String: Double]] {
        ["Metric": [
            "BitPerSecond": bps,
            "KilobitPerSecond": bps / 1e3,
            "MegabitPerSecond": bps / 1e6,
            "GigabitPerSecond": bps / 1e9,
            "BytePerSecond": bps / 8,
            "KilobytePerSecond": bps / (8 * 1e3),
            "MegabytePerSecond": bps / (8 * 1e6)
        ]]
    }
}
