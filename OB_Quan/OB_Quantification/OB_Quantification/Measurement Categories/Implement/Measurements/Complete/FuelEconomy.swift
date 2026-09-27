//
//  FuelEconomy.swift
//  OB_Quantification
//

import Foundation

struct FuelEconomy: UnitCategory {
    var name: String
    let currentPage = "Fuel Economy"
    let status = "Active"
    let isExportable = true

    let metric = [
        "LitersPer100Km", "KilometersPerLiter"
    ]

    let imperial = [
        "MilesPerGallonUS", "MilesPerGallonUK"
    ]

    let scientific: [String] = []

    let nautical: [String] = []

    // US gallon = 3.785411784 L; UK gallon = 4.54609 L; mile = 1609.344 m
    private static let milePerKm = 1.609344
    private static let usGalLiters = 3.785411784
    private static let ukGalLiters = 4.54609

    func convertedValues(value: Double, from unit: String) -> [String:[String: Double]] {
        if metric.contains(unit) {
            return convertFromMetric(value, unit: unit)
        } else if imperial.contains(unit) {
            return convertFromImperial(value, unit: unit)
        }
        return [:]
    }

    // Base = km/L (L/100km is reciprocal: km/L = 100 / L_per_100km)
    private func convertFromMetric(_ value: Double, unit: String) -> [String:[String: Double]] {
        let kmPerL: Double
        switch unit {
        case "KilometersPerLiter": kmPerL = value
        case "LitersPer100Km":
            guard value != 0 else { kmPerL = 0; break }
            kmPerL = 100.0 / value
        default: kmPerL = value
        }
        return mergeAll(kmPerL)
    }

    private func convertFromImperial(_ value: Double, unit: String) -> [String:[String: Double]] {
        let kmPerL: Double
        switch unit {
        case "MilesPerGallonUS":
            kmPerL = value * Self.milePerKm / Self.usGalLiters
        case "MilesPerGallonUK":
            kmPerL = value * Self.milePerKm / Self.ukGalLiters
        default: kmPerL = value
        }
        return mergeAll(kmPerL)
    }

    private func mergeAll(_ kmPerL: Double) -> [String:[String: Double]] {
        var result = mergeMetricValues(kmPerL)
        result.merge(mergeImperialValues(kmPerL)) { c, _ in c }
        return result
    }

    private func mergeMetricValues(_ kmPerL: Double) -> [String:[String: Double]] {
        let lPer100 = kmPerL == 0 ? 0 : 100.0 / kmPerL
        return ["Metric": [
            "KilometersPerLiter": kmPerL,
            "LitersPer100Km": lPer100
        ]]
    }

    private func mergeImperialValues(_ kmPerL: Double) -> [String:[String: Double]] {
        ["Imperial": [
            "MilesPerGallonUS": kmPerL * Self.usGalLiters / Self.milePerKm,
            "MilesPerGallonUK": kmPerL * Self.ukGalLiters / Self.milePerKm
        ]]
    }
}
