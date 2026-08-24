//
//  ScreenResolution.swift
//  OB_Quantification
//

import Foundation

struct ScreenResolution: UnitCategory {
    var name: String
    let currentPage = "Screen Resolution"
    let status = "Active"
    let isExportable = true

    let metric = [
        "PixelsPerCentimeter"
    ]

    let imperial = [
        "PixelsPerInch", "DotsPerInch"
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

    // Base = pixels per inch (PPI); 1 in = 2.54 cm
    private func convertFromMetric(_ value: Double, unit: String) -> [String:[String: Double]] {
        let ppi: Double
        switch unit {
        case "PixelsPerCentimeter": ppi = value * 2.54
        default: ppi = value
        }
        return mergeAll(ppi)
    }

    private func convertFromImperial(_ value: Double, unit: String) -> [String:[String: Double]] {
        let ppi: Double
        switch unit {
        case "PixelsPerInch", "DotsPerInch": ppi = value
        default: ppi = value
        }
        return mergeAll(ppi)
    }

    private func mergeAll(_ ppi: Double) -> [String:[String: Double]] {
        var result = mergeMetricValues(ppi)
        result.merge(mergeImperialValues(ppi)) { c, _ in c }
        return result
    }

    private func mergeMetricValues(_ ppi: Double) -> [String:[String: Double]] {
        ["Metric": ["PixelsPerCentimeter": ppi / 2.54]]
    }

    private func mergeImperialValues(_ ppi: Double) -> [String:[String: Double]] {
        ["Imperial": [
            "PixelsPerInch": ppi,
            "DotsPerInch": ppi
        ]]
    }
}
