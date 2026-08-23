//
//  Aerodynamic.swift
//  OB_Quantification
//
//  Dynamic pressure (q = ½ρV²) expressed as pressure units, plus airspeed.
// Angle of attack → Angle; Mach is dimensionless speed ratio (kept as factor of a).
//

import Foundation

struct Aerodynamic: UnitCategory {
    var name: String
    let currentPage = "Aerodynamic"
    let status = "In Progress"
    let isExportable = true

    // Dynamic / impact pressure — base = pascal
    let metric = [
        "Pascal", "Kilopascal"
    ]

    let imperial = [
        "PoundPerSquareFoot", "Psi"
    ]

    // Airspeed — base = m/s (stall speed, IAS approximations as speed)
    let scientific = [
        "MeterPerSecond", "Knot", "Mach" // Mach uses a = 343 m/s ISA sea level
    ]

    let nautical = [
        "Knot"
    ]

    // TODO: not a convertible unit without freestream/context data:
    // pressure coefficient Cp, lift/drag coefficients, flutter frequency.

    private let speedOfSoundISA = 343.0 // m/s, dry air ~20 °C

    func convertedValues(value: Double, from unit: String) -> [String:[String: Double]] {
        if metric.contains(unit) || imperial.contains(unit) {
            return convertPressure(value, unit: unit)
        } else if scientific.contains(unit) || nautical.contains(unit) {
            return convertSpeed(value, unit: unit)
        }
        return [:]
    }

    private func convertPressure(_ value: Double, unit: String) -> [String:[String: Double]] {
        let pascal: Double
        switch unit {
        case "Pascal": pascal = value
        case "Kilopascal": pascal = value * 1000.0
        case "PoundPerSquareFoot": pascal = value * 47.8803
        case "Psi": pascal = value * 6894.76
        default: pascal = value
        }
        return [
            "Metric": [
                "Pascal": pascal,
                "Kilopascal": pascal / 1000.0
            ],
            "Imperial": [
                "PoundPerSquareFoot": pascal / 47.8803,
                "Psi": pascal / 6894.76
            ]
        ]
    }

    private func convertSpeed(_ value: Double, unit: String) -> [String:[String: Double]] {
        let mps: Double
        switch unit {
        case "MeterPerSecond": mps = value
        case "Knot": mps = value * 0.514444
        case "Mach": mps = value * speedOfSoundISA
        default: mps = value
        }
        return [
            "Scientific": [
                "MeterPerSecond": mps,
                "Knot": mps / 0.514444,
                "Mach": mps / speedOfSoundISA
            ],
            "Nautical": [
                "Knot": mps / 0.514444
            ]
        ]
    }
}
