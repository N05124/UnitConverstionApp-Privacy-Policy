//
//  Torque.swift
//  OB_Quantification
//
//  Created by Arison on 11/28/25.
//

import Foundation
//
//  Torque.swift
//  OB_Quantification
//
//  Created by Arison on 11/28/25.
//

import Foundation

struct Torque: UnitCategory {
    var name: String
    let currentPage = "Torque"
    let status = "Active"
    let isExportable = true

    // MARK: - Unit Groups
    let metric = [
        "NewtonMeter", "KilonewtonMeter"
    ]

    let imperial = [
        "PoundFoot", "PoundInch"
    ]

    let scientific: [String] = [
        
    ]

    let nautical: [String] = [
        
    ]

    // MARK: - Main Conversion Router
    func convertedValues(value: Double, from unit: String) -> [String:[String: Double]] {
        if metric.contains(unit) {
            return convertFromMetric(value, unit: unit)
        } else if imperial.contains(unit) {
            return convertFromImperial(value, unit: unit)
        } else if scientific.contains(unit) {
            return convertFromScientific(value, unit: unit)
        } else if nautical.contains(unit) {
            return convertFromNautical(value, unit: unit)
        }
        return [:]
    }

    // MARK: - Conversion Helpers
    private func convertFromMetric(_ value: Double, unit: String) -> [String:[String: Double]] {
        let toNm: Double
        switch unit {
        case "NewtonMeter": toNm = value
        case "KilonewtonMeter": toNm = value * 1000
        default: toNm = value
        }

        var result = mergeMetricValues(toNm)
        result.merge(mergeImperialValues(toNm)) { c,_ in c }
        result.merge(mergeScientificValues(toNm)) { c,_ in c }
        result.merge(mergeNauticalValues(toNm)) { c,_ in c }
        return result
    }

    private func convertFromImperial(_ value: Double, unit: String) -> [String:[String: Double]] {
        let toNm: Double
        switch unit {
        case "PoundFoot": toNm = value * 1.35582
        case "PoundInch": toNm = value * 0.113
        default: toNm = value
        }

        var result = mergeImperialValues(toNm)
        result.merge(mergeMetricValues(toNm)) { c,_ in c }
        result.merge(mergeScientificValues(toNm)) { c,_ in c }
        result.merge(mergeNauticalValues(toNm)) { c,_ in c }
        return result
    }

    private func convertFromScientific(_ value: Double, unit: String) -> [String:[String: Double]] {
        return [:]
    }

    private func convertFromNautical(_ value: Double, unit: String) -> [String:[String: Double]] {
        return [:]
    }

    // MARK: - Merge Groups
    private func mergeMetricValues(_ value: Double) -> [String:[String: Double]] {
        return ["Metric": [
            "NewtonMeter": value,
            "KilonewtonMeter": value / 1000
        ]]
    }

    private func mergeImperialValues(_ value: Double) -> [String:[String: Double]] {
        return ["Imperial": [
            "PoundFoot": value / 1.35582,
            "PoundInch": value / 0.113
        ]]
    }

    private func mergeScientificValues(_ value: Double) -> [String:[String: Double]] {
        return [:]
    }

    private func mergeNauticalValues(_ value: Double) -> [String:[String: Double]] {
        return [:]
    }
}
