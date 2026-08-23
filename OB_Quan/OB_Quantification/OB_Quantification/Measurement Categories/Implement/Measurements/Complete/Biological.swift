//
//  Biological.swift
//  OB_Quantification
//
//  Rates expressible as frequency / time (heart rate, respiration).
// Most biology metrics need assay-specific calibration — left as TODOs.
//

import Foundation

struct Biological: UnitCategory {
    var name: String
    let currentPage = "Biological"
    let status = "In Progress"
    let isExportable = true

    // Base = events per second (Hz)
    let metric = [
        "PerSecond", "PerMinute", "PerHour"
    ]

    let imperial: [String] = []

    let scientific = [
        "BeatsPerMinute", "BreathsPerMinute"
    ]

    let nautical: [String] = []

    // TODO: not a convertible unit — requires reference calibration data:
    // IC50/EC50/LD50, gene expression (RPKM/TPM), CFU without plating context,
    // biodiversity indices, optical density without path length / ε,
    // antibody titer (assay-dependent).

    func convertedValues(value: Double, from unit: String) -> [String:[String: Double]] {
        if metric.contains(unit) || scientific.contains(unit) {
            return convertRate(value, unit: unit)
        }
        return [:]
    }

    private func convertRate(_ value: Double, unit: String) -> [String:[String: Double]] {
        let perSecond: Double
        switch unit {
        case "PerSecond": perSecond = value
        case "PerMinute", "BeatsPerMinute", "BreathsPerMinute": perSecond = value / 60.0
        case "PerHour": perSecond = value / 3600.0
        default: perSecond = value
        }
        return [
            "Metric": [
                "PerSecond": perSecond,
                "PerMinute": perSecond * 60.0,
                "PerHour": perSecond * 3600.0
            ],
            "Scientific": [
                "BeatsPerMinute": perSecond * 60.0,
                "BreathsPerMinute": perSecond * 60.0
            ]
        ]
    }
}
