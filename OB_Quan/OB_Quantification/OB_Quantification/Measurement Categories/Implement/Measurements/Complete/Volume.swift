import Foundation

struct Volume: UnitCategory {
    var name: String
    let currentPage = "Volume"
    let status = "Active"
    let isExportable = true

    let metric = [
        "Millimeter³", "Centimeter³", "Meter³", "Decameter³", "Hectometer³",
        "Kilometer³", "Megameter³", "Gigameter³", "Terameter³", "Petameter³",
        "Exameter³", "Zettameter³", "Yottameter³"
    ]

    let imperial = [
        "Inch³", "Foot³", "Yard³", "Chain³", "Furlong³", "Mile³", "League³"
    ]

    let scientific = [
        "Yoctometer³", "Zeptometer³", "Attometer³", "Femtometer³", "Picometer³",
        "Nanometer³", "Micrometer³", "Meter³",
        "AstronomicalUnit³", "LunarDistance³",
        "LightSecond³", "LightMinute³", "LightHour³", "LightDay³",
        "LightYear³", "Parsec³", "Kiloparsec³", "Megaparsec³", "Gigaparsec³"
    ]

    let nautical = [
        "Inch³", "Foot³", "Yard³", "Fathom³", "Cable³", "NauticalMile³"
    ]

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
        } else if nautical.contains(unit) {
            return convertFromNautical(value, unit: unit)
        } else if scientific.contains(unit) {
            return convertFromScientific(value, unit: unit)
        } else {
            return [:]
        }
    }

    // MARK: - Conversion helpers (base = cubic meters)
    private func convertFromMetric(_ value: Double, unit: String) -> [String:[String: Double]] {
        let toCubicMeters: Double
        switch unit {
        case "Millimeter³": toCubicMeters = value / 1e9
        case "Centimeter³": toCubicMeters = value / 1e6
        case "Meter³": toCubicMeters = value
        case "Decameter³": toCubicMeters = value * 1e3
        case "Hectometer³": toCubicMeters = value * 1e6
        case "Kilometer³": toCubicMeters = value * 1e9
        case "Megameter³": toCubicMeters = value * 1e18
        case "Gigameter³": toCubicMeters = value * 1e27
        case "Terameter³": toCubicMeters = value * 1e36
        case "Petameter³": toCubicMeters = value * 1e45
        case "Exameter³": toCubicMeters = value * 1e54
        case "Zettameter³": toCubicMeters = value * 1e63
        case "Yottameter³": toCubicMeters = value * 1e72
        default: toCubicMeters = value
        }
        let toCubicInches = toCubicMeters * Self.inchPerMeter * Self.inchPerMeter * Self.inchPerMeter

        var result = mergeMetricValues(toCubicMeters)
        result.merge(mergeImperialValues(toCubicInches)) { current, _ in current }
        result.merge(mergeNauticalValues(toCubicInches)) { current, _ in current }
        result.merge(mergeScientificValues(toCubicMeters)) { current, _ in current }
        return result
    }

    private func convertFromImperial(_ value: Double, unit: String) -> [String:[String: Double]] {
        let toCubicInches: Double
        switch unit {
        case "Inch³": toCubicInches = value
        case "Foot³": toCubicInches = value * (12.0 * 12.0 * 12.0)
        case "Yard³": toCubicInches = value * (36.0 * 36.0 * 36.0)
        case "Chain³": toCubicInches = value * (792.0 * 792.0 * 792.0)
        case "Furlong³": toCubicInches = value * (7920.0 * 7920.0 * 7920.0)
        case "Mile³": toCubicInches = value * (63360.0 * 63360.0 * 63360.0)
        case "League³": toCubicInches = value * (190080.0 * 190080.0 * 190080.0)
        default: toCubicInches = value
        }
        let inch = 0.0254
        let toCubicMeters = toCubicInches * inch * inch * inch

        var result = mergeImperialValues(toCubicInches)
        result.merge(mergeMetricValues(toCubicMeters)) { current, _ in current }
        result.merge(mergeNauticalValues(toCubicInches)) { current, _ in current }
        result.merge(mergeScientificValues(toCubicMeters)) { current, _ in current }
        return result
    }

    private func convertFromNautical(_ value: Double, unit: String) -> [String:[String: Double]] {
        let toCubicInches: Double
        switch unit {
        case "Inch³": toCubicInches = value
        case "Foot³": toCubicInches = value * (12.0 * 12.0 * 12.0)
        case "Yard³": toCubicInches = value * (36.0 * 36.0 * 36.0)
        case "Fathom³": toCubicInches = value * (72.0 * 72.0 * 72.0)
        case "Cable³": toCubicInches = value * (Self.cableInches * Self.cableInches * Self.cableInches)
        case "NauticalMile³": toCubicInches = value * (Self.nauticalMileInches * Self.nauticalMileInches * Self.nauticalMileInches)
        default: toCubicInches = value
        }
        let inch = 0.0254
        let toCubicMeters = toCubicInches * inch * inch * inch

        var result = mergeNauticalValues(toCubicInches)
        result.merge(mergeImperialValues(toCubicInches)) { current, _ in current }
        result.merge(mergeMetricValues(toCubicMeters)) { current, _ in current }
        result.merge(mergeScientificValues(toCubicMeters)) { current, _ in current }
        return result
    }

    private func convertFromScientific(_ value: Double, unit: String) -> [String:[String: Double]] {
        let toCubicMeters: Double
        switch unit {
        case "Yoctometer³": toCubicMeters = value / 1e72
        case "Zeptometer³": toCubicMeters = value / 1e63
        case "Attometer³": toCubicMeters = value / 1e54
        case "Femtometer³": toCubicMeters = value / 1e45
        case "Picometer³": toCubicMeters = value / 1e36
        case "Nanometer³": toCubicMeters = value / 1e27
        case "Micrometer³": toCubicMeters = value / 1e18
        case "Meter³": toCubicMeters = value
        case "AstronomicalUnit³": toCubicMeters = value * pow(1.496e11, 3)
        case "LunarDistance³": toCubicMeters = value * pow(3.844e8, 3)
        case "LightSecond³": toCubicMeters = value * pow(2.998e8, 3)
        case "LightMinute³": toCubicMeters = value * pow(1.799e10, 3)
        case "LightHour³": toCubicMeters = value * pow(1.079e12, 3)
        case "LightDay³": toCubicMeters = value * pow(2.590e13, 3)
        case "LightYear³": toCubicMeters = value * pow(9.461e15, 3)
        case "Parsec³": toCubicMeters = value * pow(3.086e16, 3)
        case "Kiloparsec³": toCubicMeters = value * pow(3.086e19, 3)
        case "Megaparsec³": toCubicMeters = value * pow(3.086e22, 3)
        case "Gigaparsec³": toCubicMeters = value * pow(3.086e25, 3)
        default: toCubicMeters = value
        }
        let toCubicInches = toCubicMeters * Self.inchPerMeter * Self.inchPerMeter * Self.inchPerMeter

        var result = mergeScientificValues(toCubicMeters)
        result.merge(mergeImperialValues(toCubicInches)) { current, _ in current }
        result.merge(mergeMetricValues(toCubicMeters)) { current, _ in current }
        result.merge(mergeNauticalValues(toCubicInches)) { current, _ in current }
        return result
    }

    // MARK: - Merge Dictionaries (base: m³ or in³)
    private func mergeMetricValues(_ cubicMeters: Double) -> [String:[String: Double]] {
        [
            "Metric": [
                "Millimeter³": cubicMeters * 1e9,
                "Centimeter³": cubicMeters * 1e6,
                "Meter³": cubicMeters,
                "Decameter³": cubicMeters / 1e3,
                "Hectometer³": cubicMeters / 1e6,
                "Kilometer³": cubicMeters / 1e9,
                "Megameter³": cubicMeters / 1e18,
                "Gigameter³": cubicMeters / 1e27,
                "Terameter³": cubicMeters / 1e36,
                "Petameter³": cubicMeters / 1e45,
                "Exameter³": cubicMeters / 1e54,
                "Zettameter³": cubicMeters / 1e63,
                "Yottameter³": cubicMeters / 1e72
            ]
        ]
    }

    private func mergeImperialValues(_ cubicInches: Double) -> [String:[String: Double]] {
        [
            "Imperial": [
                "Inch³": cubicInches,
                "Foot³": cubicInches / (12.0 * 12.0 * 12.0),
                "Yard³": cubicInches / (36.0 * 36.0 * 36.0),
                "Chain³": cubicInches / (792.0 * 792.0 * 792.0),
                "Furlong³": cubicInches / (7920.0 * 7920.0 * 7920.0),
                "Mile³": cubicInches / (63360.0 * 63360.0 * 63360.0),
                "League³": cubicInches / (190080.0 * 190080.0 * 190080.0)
            ]
        ]
    }

    private func mergeNauticalValues(_ cubicInches: Double) -> [String:[String: Double]] {
        [
            "Nautical": [
                "Inch³": cubicInches,
                "Foot³": cubicInches / (12.0 * 12.0 * 12.0),
                "Yard³": cubicInches / (36.0 * 36.0 * 36.0),
                "Fathom³": cubicInches / (72.0 * 72.0 * 72.0),
                "Cable³": cubicInches / (Self.cableInches * Self.cableInches * Self.cableInches),
                "NauticalMile³": cubicInches / (Self.nauticalMileInches * Self.nauticalMileInches * Self.nauticalMileInches)
            ]
        ]
    }

    private func mergeScientificValues(_ cubicMeters: Double) -> [String:[String: Double]] {
        [
            "Scientific": [
                "Yoctometer³": cubicMeters * 1e72,
                "Zeptometer³": cubicMeters * 1e63,
                "Attometer³": cubicMeters * 1e54,
                "Femtometer³": cubicMeters * 1e45,
                "Picometer³": cubicMeters * 1e36,
                "Nanometer³": cubicMeters * 1e27,
                "Micrometer³": cubicMeters * 1e18,
                "Meter³": cubicMeters,
                "AstronomicalUnit³": cubicMeters / pow(1.496e11, 3),
                "LunarDistance³": cubicMeters / pow(3.844e8, 3),
                "LightSecond³": cubicMeters / pow(2.998e8, 3),
                "LightMinute³": cubicMeters / pow(1.799e10, 3),
                "LightHour³": cubicMeters / pow(1.079e12, 3),
                "LightDay³": cubicMeters / pow(2.590e13, 3),
                "LightYear³": cubicMeters / pow(9.461e15, 3),
                "Parsec³": cubicMeters / pow(3.086e16, 3),
                "Kiloparsec³": cubicMeters / pow(3.086e19, 3),
                "Megaparsec³": cubicMeters / pow(3.086e22, 3),
                "Gigaparsec³": cubicMeters / pow(3.086e25, 3)
            ]
        ]
    }
}
