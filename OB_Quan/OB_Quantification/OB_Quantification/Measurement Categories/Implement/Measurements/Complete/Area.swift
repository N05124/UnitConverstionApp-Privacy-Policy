//
//  Area.swift
//  OB_Quantification
//
//  Created by Arison on 11/22/25.
//

import Foundation

struct Area: UnitCategory {
    var name: String
    let currentPage = "Area"
    let status = "Active"
    let isExportable = true

    let metric = [
        "Millimeter²", "Centimeter²", "Meter²", "Decameter²", "Hectometer²",
        "Kilometer²", "Megameter²", "Gigameter²", "Terameter²", "Petameter²",
        "Exameter²", "Zettameter²", "Yottameter²"
    ]

    let imperial = [
        "Inch²", "Foot²", "Yard²", "Chain²", "Furlong²", "Mile²", "League²"
    ]

    let scientific = [
        "Yoctometer²", "Zeptometer²", "Attometer²", "Femtometer²", "Picometer²",
        "Nanometer²", "Micrometer²", "Meter²",
        "AstronomicalUnit²", "LunarDistance²",
        "LightSecond²", "LightMinute²", "LightHour²", "LightDay²",
        "LightYear²", "Parsec²", "Kiloparsec²", "Megaparsec²", "Gigaparsec²"
    ]

    let nautical = [
        "Inch²", "Foot²", "Yard²", "Fathom²", "Cable²", "NauticalMile²"
    ]

    // Linear inch factors used for area via factor²
    private static let inchPerMeter = 1.0 / 0.0254
    // 1 international cable = 1/10 nmi = 185.2 m = 7291.34 in
    private static let cableInches = 7291.34
    private static let nauticalMileInches = 72913.4

    // MARK: - Dynamic Conversion Logic
    func convertedValues(value: Double, from unit: String) -> [String:[String: Double]] {
        if metric.contains(unit) {
            return convertFromMetric(value, unit: unit)
        } else if imperial.contains(unit) {
            return convertFromImperial(value, unit: unit)
        } else if scientific.contains(unit) {
            return convertFromScientific(value, unit: unit)
        } else if nautical.contains(unit) {
            return convertFromNautical(value, unit: unit)
        } else {
            return [:]
        }
    }

    // MARK: - Internal Conversion Handlers (base = square meters)
    private func convertFromMetric(_ value: Double, unit: String) -> [String:[String: Double]] {
        let toSquareMeters: Double
        switch unit {
        case "Millimeter²": toSquareMeters = value / 1e6
        case "Centimeter²": toSquareMeters = value / 1e4
        case "Meter²": toSquareMeters = value
        case "Decameter²": toSquareMeters = value * 100
        case "Hectometer²": toSquareMeters = value * 1e4
        case "Kilometer²": toSquareMeters = value * 1e6
        case "Megameter²": toSquareMeters = value * 1e12
        case "Gigameter²": toSquareMeters = value * 1e18
        case "Terameter²": toSquareMeters = value * 1e24
        case "Petameter²": toSquareMeters = value * 1e30
        case "Exameter²": toSquareMeters = value * 1e36
        case "Zettameter²": toSquareMeters = value * 1e42
        case "Yottameter²": toSquareMeters = value * 1e48
        default: toSquareMeters = value
        }
        let toSquareInches = toSquareMeters * Self.inchPerMeter * Self.inchPerMeter

        var result = mergeMetricValues(toSquareMeters)
        result.merge(mergeImperialValues(toSquareInches)) { current, _ in current }
        result.merge(mergeScientificValues(toSquareMeters)) { current, _ in current }
        result.merge(mergeNauticalValues(toSquareInches)) { current, _ in current }
        return result
    }

    private func convertFromImperial(_ value: Double, unit: String) -> [String:[String: Double]] {
        let toSquareInches: Double
        switch unit {
        case "Inch²": toSquareInches = value
        case "Foot²": toSquareInches = value * 144.0
        case "Yard²": toSquareInches = value * 1296.0
        case "Chain²": toSquareInches = value * (792.0 * 792.0)
        case "Furlong²": toSquareInches = value * (7920.0 * 7920.0)
        case "Mile²": toSquareInches = value * (63360.0 * 63360.0)
        case "League²": toSquareInches = value * (190080.0 * 190080.0)
        default: toSquareInches = value
        }
        let toSquareMeters = toSquareInches * 0.0254 * 0.0254

        var result = mergeImperialValues(toSquareInches)
        result.merge(mergeMetricValues(toSquareMeters)) { current, _ in current }
        result.merge(mergeScientificValues(toSquareMeters)) { current, _ in current }
        result.merge(mergeNauticalValues(toSquareInches)) { current, _ in current }
        return result
    }

    private func convertFromNautical(_ value: Double, unit: String) -> [String:[String: Double]] {
        let toSquareInches: Double
        switch unit {
        case "Inch²": toSquareInches = value
        case "Foot²": toSquareInches = value * 144.0
        case "Yard²": toSquareInches = value * 1296.0
        case "Fathom²": toSquareInches = value * (72.0 * 72.0)
        case "Cable²": toSquareInches = value * (Self.cableInches * Self.cableInches)
        case "NauticalMile²": toSquareInches = value * (Self.nauticalMileInches * Self.nauticalMileInches)
        default: toSquareInches = value
        }
        let toSquareMeters = toSquareInches * 0.0254 * 0.0254

        var result = mergeNauticalValues(toSquareInches)
        result.merge(mergeImperialValues(toSquareInches)) { current, _ in current }
        result.merge(mergeMetricValues(toSquareMeters)) { current, _ in current }
        result.merge(mergeScientificValues(toSquareMeters)) { current, _ in current }
        return result
    }

    private func convertFromScientific(_ value: Double, unit: String) -> [String:[String: Double]] {
        let toSquareMeters: Double
        switch unit {
        case "Yoctometer²": toSquareMeters = value / 1e48
        case "Zeptometer²": toSquareMeters = value / 1e42
        case "Attometer²": toSquareMeters = value / 1e36
        case "Femtometer²": toSquareMeters = value / 1e30
        case "Picometer²": toSquareMeters = value / 1e24
        case "Nanometer²": toSquareMeters = value / 1e18
        case "Micrometer²": toSquareMeters = value / 1e12
        case "Meter²": toSquareMeters = value
        case "AstronomicalUnit²": toSquareMeters = value * (1.496e11 * 1.496e11)
        case "LunarDistance²": toSquareMeters = value * (3.844e8 * 3.844e8)
        case "LightSecond²": toSquareMeters = value * (2.998e8 * 2.998e8)
        case "LightMinute²": toSquareMeters = value * (1.799e10 * 1.799e10)
        case "LightHour²": toSquareMeters = value * (1.079e12 * 1.079e12)
        case "LightDay²": toSquareMeters = value * (2.590e13 * 2.590e13)
        case "LightYear²": toSquareMeters = value * (9.461e15 * 9.461e15)
        case "Parsec²": toSquareMeters = value * (3.086e16 * 3.086e16)
        case "Kiloparsec²": toSquareMeters = value * (3.086e19 * 3.086e19)
        case "Megaparsec²": toSquareMeters = value * (3.086e22 * 3.086e22)
        case "Gigaparsec²": toSquareMeters = value * (3.086e25 * 3.086e25)
        default: toSquareMeters = value
        }
        let toSquareInches = toSquareMeters * Self.inchPerMeter * Self.inchPerMeter

        var result = mergeScientificValues(toSquareMeters)
        result.merge(mergeImperialValues(toSquareInches)) { current, _ in current }
        result.merge(mergeMetricValues(toSquareMeters)) { current, _ in current }
        result.merge(mergeNauticalValues(toSquareInches)) { current, _ in current }
        return result
    }

    // MARK: - Merge Dictionaries (base: m² or in²)
    private func mergeNauticalValues(_ squareInches: Double) -> [String:[String: Double]] {
        [
            "Nautical": [
                "Inch²": squareInches,
                "Foot²": squareInches / 144.0,
                "Yard²": squareInches / 1296.0,
                "Fathom²": squareInches / (72.0 * 72.0),
                "Cable²": squareInches / (Self.cableInches * Self.cableInches),
                "NauticalMile²": squareInches / (Self.nauticalMileInches * Self.nauticalMileInches)
            ]
        ]
    }

    private func mergeImperialValues(_ squareInches: Double) -> [String:[String: Double]] {
        [
            "Imperial": [
                "Inch²": squareInches,
                "Foot²": squareInches / 144.0,
                "Yard²": squareInches / 1296.0,
                "Chain²": squareInches / (792.0 * 792.0),
                "Furlong²": squareInches / (7920.0 * 7920.0),
                "Mile²": squareInches / (63360.0 * 63360.0),
                "League²": squareInches / (190080.0 * 190080.0)
            ]
        ]
    }

    private func mergeMetricValues(_ squareMeters: Double) -> [String:[String: Double]] {
        [
            "Metric": [
                "Millimeter²": squareMeters * 1e6,
                "Centimeter²": squareMeters * 1e4,
                "Meter²": squareMeters,
                "Decameter²": squareMeters / 100,
                "Hectometer²": squareMeters / 1e4,
                "Kilometer²": squareMeters / 1e6,
                "Megameter²": squareMeters / 1e12,
                "Gigameter²": squareMeters / 1e18,
                "Terameter²": squareMeters / 1e24,
                "Petameter²": squareMeters / 1e30,
                "Exameter²": squareMeters / 1e36,
                "Zettameter²": squareMeters / 1e42,
                "Yottameter²": squareMeters / 1e48
            ]
        ]
    }

    private func mergeScientificValues(_ squareMeters: Double) -> [String:[String: Double]] {
        [
            "Scientific": [
                "Yoctometer²": squareMeters * 1e48,
                "Zeptometer²": squareMeters * 1e42,
                "Attometer²": squareMeters * 1e36,
                "Femtometer²": squareMeters * 1e30,
                "Picometer²": squareMeters * 1e24,
                "Nanometer²": squareMeters * 1e18,
                "Micrometer²": squareMeters * 1e12,
                "Meter²": squareMeters,
                "AstronomicalUnit²": squareMeters / (1.496e11 * 1.496e11),
                "LunarDistance²": squareMeters / (3.844e8 * 3.844e8),
                "LightSecond²": squareMeters / (2.998e8 * 2.998e8),
                "LightMinute²": squareMeters / (1.799e10 * 1.799e10),
                "LightHour²": squareMeters / (1.079e12 * 1.079e12),
                "LightDay²": squareMeters / (2.590e13 * 2.590e13),
                "LightYear²": squareMeters / (9.461e15 * 9.461e15),
                "Parsec²": squareMeters / (3.086e16 * 3.086e16),
                "Kiloparsec²": squareMeters / (3.086e19 * 3.086e19),
                "Megaparsec²": squareMeters / (3.086e22 * 3.086e22),
                "Gigaparsec²": squareMeters / (3.086e25 * 3.086e25)
            ]
        ]
    }
}
