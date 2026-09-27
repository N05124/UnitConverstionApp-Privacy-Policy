//
//  ThreadPitch.swift
//  OB_Quantification
//

import Foundation

struct ThreadPitch: UnitCategory {
    var name: String
    let currentPage = "Thread Pitch"
    let status = "Active"
    let isExportable = true

    let metric = [
        "MillimeterPitch"
    ]

    let imperial = [
        "ThreadsPerInch"
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

    // Base = mm per thread; TPI = 25.4 / pitch_mm (inverse)
    private func convertFromMetric(_ value: Double, unit: String) -> [String:[String: Double]] {
        let pitchMm: Double
        switch unit {
        case "MillimeterPitch": pitchMm = value
        default: pitchMm = value
        }
        return mergeAll(pitchMm)
    }

    private func convertFromImperial(_ value: Double, unit: String) -> [String:[String: Double]] {
        let pitchMm: Double
        switch unit {
        case "ThreadsPerInch":
            guard value != 0 else { pitchMm = 0; break }
            pitchMm = 25.4 / value
        default: pitchMm = value
        }
        return mergeAll(pitchMm)
    }

    private func mergeAll(_ pitchMm: Double) -> [String:[String: Double]] {
        var result = mergeMetricValues(pitchMm)
        result.merge(mergeImperialValues(pitchMm)) { c, _ in c }
        return result
    }

    private func mergeMetricValues(_ pitchMm: Double) -> [String:[String: Double]] {
        ["Metric": ["MillimeterPitch": pitchMm]]
    }

    private func mergeImperialValues(_ pitchMm: Double) -> [String:[String: Double]] {
        let tpi = pitchMm == 0 ? 0 : 25.4 / pitchMm
        return ["Imperial": ["ThreadsPerInch": tpi]]
    }
}
