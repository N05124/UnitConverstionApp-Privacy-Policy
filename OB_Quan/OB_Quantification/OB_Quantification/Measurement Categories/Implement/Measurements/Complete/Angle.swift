//
//  Angle.swift
//  OB_Quantification
//
//  Created by Arison on 11/28/25.
//

import Foundation

struct Angle: UnitCategory {
    var name: String
    let currentPage = "Angle"
    let status = "Active"
    let isExportable = true

    // MARK: - Unit Groups
    let metric = [
        "Milliradian", "Radian"
    ]

    let imperial = [
        "Degree", "ArcMinute", "ArcSecond"
    ]

    let scientific = [
        "Gradian", "Turn"
    ]
    
    let nautical = [
        "Point"
    ]
    
    let mathematical = [
        "PiOver6", "PiOver4", "PiOver3", "PiOver2", "Pi", "ThreePiOver2", "TwoPi"
    ]

    // MARK: - Main Conversion Router
    func convertedValues(value: Double, from unit: String) -> [String:[String: Double]] {
        if metric.contains(unit) {
            return convertFromMetric(value, unit: unit)
        } else if imperial.contains(unit) {
            return convertFromImperial(value, unit: unit)
        } else if nautical.contains(unit) {
            return convertFromNautical(value, unit: unit)
        } else if scientific.contains(unit) {
            return convertFromScientific(value, unit: unit)
        } else if mathematical.contains(unit) {
            return convertFromMathematical(value, unit: unit)
        }
        return [:]
    }

    // MARK: - Conversion Helpers
    private func convertFromMetric(_ value: Double, unit: String) -> [String:[String: Double]] {
        let toRad: Double
        switch unit {
        case "Milliradian": toRad = value / 1000
        case "Radian": toRad = value
        default: toRad = value
        }
        var result = mergeMetricValues(toRad)
        result.merge(mergeImperialValues(toRad)) { c,_ in c }
        result.merge(mergeNauticalValues(toRad)) { c,_ in c }
        result.merge(mergeScientificValues(toRad)) { c,_ in c }
        result.merge(mergeMathematicalValues(toRad)) { c,_ in c }
        return result
    }

    private func convertFromImperial(_ value: Double, unit: String) -> [String:[String: Double]] {
        let toRad: Double
        switch unit {
        case "Degree": toRad = value * .pi / 180
        case "ArcMinute": toRad = value * .pi / (180 * 60)
        case "ArcSecond": toRad = value * .pi / (180 * 3600)
        default: toRad = value
        }
        var result = mergeImperialValues(toRad)
        result.merge(mergeMetricValues(toRad)) { c,_ in c }
        result.merge(mergeNauticalValues(toRad)) { c,_ in c }
        result.merge(mergeScientificValues(toRad)) { c,_ in c }
        result.merge(mergeMathematicalValues(toRad)) { c,_ in c }
        return result
    }

    private func convertFromNautical(_ value: Double, unit: String) -> [String:[String: Double]] {
        let toRad: Double
        switch unit {
        case "Point": toRad = value * (.pi / 16)  // 1 point = 11.25°
        default: toRad = value
        }
        var result = mergeNauticalValues(toRad)
        result.merge(mergeMetricValues(toRad)) { c,_ in c }
        result.merge(mergeImperialValues(toRad)) { c,_ in c }
        result.merge(mergeScientificValues(toRad)) { c,_ in c }
        result.merge(mergeMathematicalValues(toRad)) { c,_ in c }
        return result
    }

    private func convertFromScientific(_ value: Double, unit: String) -> [String:[String: Double]] {
        let toRad: Double
        switch unit {
        case "Gradian": toRad = value * .pi / 200
        case "Turn": toRad = value * 2 * .pi
        default: toRad = value
        }
        var result = mergeScientificValues(toRad)
        result.merge(mergeMetricValues(toRad)) { c,_ in c }
        result.merge(mergeImperialValues(toRad)) { c,_ in c }
        result.merge(mergeNauticalValues(toRad)) { c,_ in c }
        result.merge(mergeMathematicalValues(toRad)) { c,_ in c }
        return result
    }

    private func convertFromMathematical(_ value: Double, unit: String) -> [String:[String: Double]] {
        let toRad: Double
        switch unit {
        case "PiOver6": toRad = .pi / 6
        case "PiOver4": toRad = .pi / 4
        case "PiOver3": toRad = .pi / 3
        case "PiOver2": toRad = .pi / 2
        case "Pi": toRad = .pi
        case "ThreePiOver2": toRad = 3 * .pi / 2
        case "TwoPi": toRad = 2 * .pi
        default: toRad = value
        }
        var result = mergeMathematicalValues(toRad)
        result.merge(mergeMetricValues(toRad)) { c,_ in c }
        result.merge(mergeImperialValues(toRad)) { c,_ in c }
        result.merge(mergeNauticalValues(toRad)) { c,_ in c }
        result.merge(mergeScientificValues(toRad)) { c,_ in c }
        return result
    }

    // MARK: - Merge Groups
    private func mergeMetricValues(_ value: Double) -> [String:[String: Double]] {
        return ["Metric": [
            "Milliradian": value * 1000,
            "Radian": value
        ]]
    }

    private func mergeImperialValues(_ value: Double) -> [String:[String: Double]] {
        return ["Imperial": [
            "Degree": value * 180 / .pi,
            "ArcMinute": value * 180 * 60 / .pi,
            "ArcSecond": value * 180 * 3600 / .pi
        ]]
    }

    private func mergeNauticalValues(_ value: Double) -> [String:[String: Double]] {
        return ["Nautical": [
            "Point": value / (.pi / 16)
        ]]
    }

    private func mergeScientificValues(_ value: Double) -> [String:[String: Double]] {
        return ["Scientific": [
            "Gradian": value * 200 / .pi,
            "Turn": value / (2 * .pi)
        ]]
    }
    
    private func mergeMathematicalValues(_ value: Double) -> [String:[String: Double]] {
        return ["Mathematical": [
            "PiOver6": value / (.pi / 6),
            "PiOver4": value / (.pi / 4),
            "PiOver3": value / (.pi / 3),
            "PiOver2": value / (.pi / 2),
            "Pi": value / .pi,
            "ThreePiOver2": value / (3 * .pi / 2),
            "TwoPi": value / (2 * .pi)
        ]]
    }
}
