//
//  ImageResolution.swift
//  OB_Quantification
//

import Foundation

struct ImageResolution: UnitCategory {
    var name: String
    let currentPage = "Image Resolution"
    let status = "Active"
    let isExportable = true

    let metric = [
        "Megapixel"
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
        let megapixel: Double
        switch unit {
        case "Megapixel": megapixel = value
        default: megapixel = value
        }
        return mergeMetricValues(megapixel)
    }

    private func mergeMetricValues(_ megapixel: Double) -> [String:[String: Double]] {
        ["Metric": ["Megapixel": megapixel]]
    }
}
