//
//  Perceptual.swift
//  OB_Quantification
//
//  Information rate and color temperature (kelvin). Subjective scales skipped.
//

import Foundation

struct Perceptual: UnitCategory {
    var name: String
    let currentPage = "Perceptual"
    let status = "In Progress"
    let isExportable = true

    // Data rate — base = bit/s
    let metric = [
        "BitPerSecond", "KilobitPerSecond", "MegabitPerSecond", "GigabitPerSecond"
    ]

    let imperial = [
        "BytePerSecond", "KibibytePerSecond", "MebibytePerSecond"
    ]

    // Color temperature — base = kelvin (same affine as Thermodynamic kelvin)
    let scientific = [
        "Kelvin"
    ]

    let nautical: [String] = []

    // TODO: not a convertible unit — requires reference calibration data:
    // Mean Opinion Score (MOS), Likert / psychometric scales, JND modality scales,
    // loudness in sones (depends on spectrum / weighting), perplexity (model-specific).

    func convertedValues(value: Double, from unit: String) -> [String:[String: Double]] {
        if metric.contains(unit) || imperial.contains(unit) {
            return convertDataRate(value, unit: unit)
        } else if scientific.contains(unit) {
            return ["Scientific": ["Kelvin": value]]
        }
        return [:]
    }

    private func convertDataRate(_ value: Double, unit: String) -> [String:[String: Double]] {
        let bps: Double
        switch unit {
        case "BitPerSecond": bps = value
        case "KilobitPerSecond": bps = value * 1e3
        case "MegabitPerSecond": bps = value * 1e6
        case "GigabitPerSecond": bps = value * 1e9
        case "BytePerSecond": bps = value * 8.0
        case "KibibytePerSecond": bps = value * 8.0 * 1024.0
        case "MebibytePerSecond": bps = value * 8.0 * 1024.0 * 1024.0
        default: bps = value
        }
        return [
            "Metric": [
                "BitPerSecond": bps,
                "KilobitPerSecond": bps / 1e3,
                "MegabitPerSecond": bps / 1e6,
                "GigabitPerSecond": bps / 1e9
            ],
            "Imperial": [
                "BytePerSecond": bps / 8.0,
                "KibibytePerSecond": bps / (8.0 * 1024.0),
                "MebibytePerSecond": bps / (8.0 * 1024.0 * 1024.0)
            ]
        ]
    }
}
