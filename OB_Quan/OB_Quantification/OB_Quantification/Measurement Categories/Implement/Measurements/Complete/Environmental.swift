//
//  Environmental.swift
//  OB_Quantification
//
//  Precipitation depth and absolute humidity. Temperature → Thermodynamic;
// relative humidity → Saturation; barometric pressure → Pressure;
// wind speed → Speed.
//

import Foundation

struct Environmental: UnitCategory {
    var name: String
    let currentPage = "Environmental"
    let status = "In Progress"
    let isExportable = true

    // Precipitation depth — base = meters of water equivalent
    let metric = [
        "Millimeter", "Centimeter", "Meter"
    ]

    let imperial = [
        "Inch"
    ]

    // Absolute humidity — base = kg/m³
    let scientific = [
        "KilogramPerCubicMeter", "GramPerCubicMeter"
    ]

    let nautical: [String] = []

    // TODO: not a convertible unit — requires reference calibration data:
    // Air Quality Index (region-specific breakpoints), chlorophyll fluorescence
    // relative scales, ecosystem productivity indices without carbon models.

    func convertedValues(value: Double, from unit: String) -> [String:[String: Double]] {
        if metric.contains(unit) || imperial.contains(unit) {
            return convertPrecipitation(value, unit: unit)
        } else if scientific.contains(unit) {
            return convertHumidity(value, unit: unit)
        }
        return [:]
    }

    private func convertPrecipitation(_ value: Double, unit: String) -> [String:[String: Double]] {
        let meters: Double
        switch unit {
        case "Millimeter": meters = value / 1000.0
        case "Centimeter": meters = value / 100.0
        case "Meter": meters = value
        case "Inch": meters = value * 0.0254
        default: meters = value
        }
        let result: [String:[String: Double]] = [
            "Metric": [
                "Millimeter": meters * 1000.0,
                "Centimeter": meters * 100.0,
                "Meter": meters
            ],
            "Imperial": [
                "Inch": meters / 0.0254
            ]
        ]
        return result
    }

    private func convertHumidity(_ value: Double, unit: String) -> [String:[String: Double]] {
        let kgm3: Double
        switch unit {
        case "KilogramPerCubicMeter": kgm3 = value
        case "GramPerCubicMeter": kgm3 = value / 1000.0
        default: kgm3 = value
        }
        return [
            "Scientific": [
                "KilogramPerCubicMeter": kgm3,
                "GramPerCubicMeter": kgm3 * 1000.0
            ]
        ]
    }
}
