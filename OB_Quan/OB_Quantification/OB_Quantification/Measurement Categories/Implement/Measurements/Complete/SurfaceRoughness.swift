//
//  SurfaceRoughness.swift
//  OB_Quantification
//

import Foundation

struct SurfaceRoughness: UnitCategory {
    var name: String
    let currentPage = "Surface Roughness"
    let status = "Active"
    let isExportable = true

    let metric = [
        "MicrometerRa"
    ]

    let imperial = [
        "MicroinchRa"
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

    // Base = µm Ra; 1 microinch = 0.0254 µm
    private static let microinchToMicrometer = 0.0254

    private func convertFromMetric(_ value: Double, unit: String) -> [String:[String: Double]] {
        let um: Double
        switch unit {
        case "MicrometerRa": um = value
        default: um = value
        }
        return mergeAll(um)
    }

    private func convertFromImperial(_ value: Double, unit: String) -> [String:[String: Double]] {
        let um: Double
        switch unit {
        case "MicroinchRa": um = value * Self.microinchToMicrometer
        default: um = value
        }
        return mergeAll(um)
    }

    private func mergeAll(_ um: Double) -> [String:[String: Double]] {
        var result = mergeMetricValues(um)
        result.merge(mergeImperialValues(um)) { c, _ in c }
        return result
    }

    private func mergeMetricValues(_ um: Double) -> [String:[String: Double]] {
        ["Metric": ["MicrometerRa": um]]
    }

    private func mergeImperialValues(_ um: Double) -> [String:[String: Double]] {
        ["Imperial": ["MicroinchRa": um / Self.microinchToMicrometer]]
    }
}
