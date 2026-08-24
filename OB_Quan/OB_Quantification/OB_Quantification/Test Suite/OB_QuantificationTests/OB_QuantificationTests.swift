//
//  OB_QuantificationTests.swift
//  OB_QuantificationTests
//
//  Created by Arison on 11/5/25.
//

import Foundation
import Testing
@testable import OB_Quantification

struct OB_QuantificationTests {

    private let tol = 1e-4

    private func lookup(
        _ result: [String: [String: Double]],
        _ group: String,
        _ unit: String
    ) -> Double {
        guard let value = result[group]?[unit] else {
            Issue.record("Missing \(group).\(unit) in \(result.keys.sorted())")
            return .nan
        }
        return value
    }

    private func expectNear(_ actual: Double, _ expected: Double, _ message: String = "") {
        #expect(
            abs(actual - expected) <= max(tol, tol * max(abs(expected), 1.0)),
            "\(message) actual=\(actual) expected=\(expected)"
        )
    }

    // MARK: - Original 11 + Phase 2 (19 registered Complete/Implement promotions)

    @Test func lengthWithinGroupAndCrossGroup() {
        let cat = Length(name: "Meters")
        let km = cat.convertedValues(value: 1.0, from: "Kilometer")
        expectNear(lookup(km, "Metric", "Meter"), 1000.0, "1 km → m")
        expectNear(lookup(km, "Imperial", "Mile"), 1000.0 / 1609.344, "1 km → mi")
        // Cable factor regression
        let cable = cat.convertedValues(value: 1.0, from: "Cable")
        expectNear(lookup(cable, "Nautical", "Cable"), 1.0, "Cable round-trip")
        expectNear(lookup(cable, "Nautical", "NauticalMile"), 0.1, "1 cable = 0.1 nmi")
    }

    @Test func volumeWithinAndCross() {
        let cat = Volume(name: "Meters")
        let out = cat.convertedValues(value: 1.0, from: "Meter³")
        expectNear(lookup(out, "Metric", "Centimeter³"), 1e6, "1 m³ → cm³")
        expectNear(lookup(out, "Imperial", "Foot³"), 1.0 / pow(0.3048, 3), "1 m³ → ft³")
    }

    @Test func areaWithinAndCross() {
        let cat = Area(name: "Meters")
        let out = cat.convertedValues(value: 1.0, from: "Meter²")
        expectNear(lookup(out, "Metric", "Centimeter²"), 1e4, "1 m² → cm²")
        expectNear(lookup(out, "Imperial", "Foot²"), 1.0 / pow(0.3048, 2), "1 m² → ft²")
    }

    @Test func weightWithinAndCross() {
        let cat = Weight(name: "Kilogram")
        let out = cat.convertedValues(value: 1.0, from: "Kilogram")
        expectNear(lookup(out, "Metric", "Gram"), 1000.0)
        expectNear(lookup(out, "Imperial", "Pound"), 2.20462)
    }

    @Test func liquidVolumeWithinAndCross() {
        let cat = LiquidVolume(name: "Liters")
        let out = cat.convertedValues(value: 1.0, from: "Liter")
        expectNear(lookup(out, "Metric", "Milliliter"), 1000.0)
        expectNear(lookup(out, "Imperial", "Gallon"), 1.0 / 3.78541)
    }

    @Test func angleWithinAndCross() {
        let cat = Angle(name: "Radian")
        let out = cat.convertedValues(value: .pi, from: "Radian")
        expectNear(lookup(out, "Imperial", "Degree"), 180.0)
        expectNear(lookup(out, "Scientific", "Turn"), 0.5)
    }

    @Test func accelerationWithinAndCross() {
        let cat = Acceleration(name: "MeterPerSecondSquared")
        let out = cat.convertedValues(value: 9.80665, from: "MeterPerSecondSquared")
        expectNear(lookup(out, "Scientific", "StandardGravity"), 1.0)
        expectNear(lookup(out, "Imperial", "FootPerSecondSquared"), 9.80665 / 0.3048)
    }

    @Test func densityWithinAndCross() {
        let cat = Density(name: "KilogramPerCubicMeter")
        let out = cat.convertedValues(value: 1000.0, from: "KilogramPerCubicMeter")
        expectNear(lookup(out, "Metric", "GramPerCubicCentimeter"), 1.0)
        expectNear(lookup(out, "Imperial", "PoundPerCubicFoot"), 1000.0 / 16.0185)
    }

    @Test func electricityWithinGroup() {
        let cat = Electricity(name: "Ampere")
        let out = cat.convertedValues(value: 1.0, from: "Ampere")
        expectNear(lookup(out, "Metric", "Milliampere"), 1000.0)
        expectNear(lookup(out, "Imperial", "Abampere"), 0.1)
    }

    @Test func energyWithinAndCross() {
        let cat = Energy(name: "Joule")
        let out = cat.convertedValues(value: 4184.0, from: "Joule")
        expectNear(lookup(out, "Metric", "Kilocalorie"), 1.0)
        expectNear(lookup(out, "Imperial", "FootPound"), 4184.0 / 1.35582)
    }

    @Test func forceWithinAndCross() {
        let cat = Force(name: "Newtons")
        let out = cat.convertedValues(value: 1.0, from: "Newton")
        expectNear(lookup(out, "Metric", "Millinewton"), 1000.0)
        expectNear(lookup(out, "Imperial", "PoundForce"), 1.0 / 4.44822)
    }

    @Test func powerWithinAndCross() {
        let cat = Power(name: "Watt")
        let out = cat.convertedValues(value: 745.7, from: "Watt")
        expectNear(lookup(out, "Imperial", "Horsepower"), 1.0)
        expectNear(lookup(out, "Metric", "Kilowatt"), 0.7457)
    }

    @Test func illuminationWithinAndCross() {
        let cat = Illumination(name: "Lux")
        let out = cat.convertedValues(value: 10.7639, from: "Lux")
        expectNear(lookup(out, "Imperial", "FootCandle"), 1.0)
        expectNear(lookup(out, "Scientific", "Phot"), 10.7639 / 10000.0)
    }

    @Test func saturationWithinGroup() {
        let cat = Saturation(name: "Percent")
        let out = cat.convertedValues(value: 50.0, from: "Percent")
        expectNear(lookup(out, "Metric", "Fraction"), 0.5)
        let back = cat.convertedValues(value: 0.25, from: "Fraction")
        expectNear(lookup(back, "Metric", "Percent"), 25.0)
    }

    @Test func pressureWithinAndCross() {
        let cat = Pressure(name: "Pascal")
        let out = cat.convertedValues(value: 101325.0, from: "Pascal")
        expectNear(lookup(out, "Metric", "Bar"), 1.01325)
        expectNear(lookup(out, "Imperial", "Psi"), 101325.0 / 6894.76)
    }

    @Test func temporalWithinAndCross() {
        let cat = Temporal(name: "Second")
        let out = cat.convertedValues(value: 3600.0, from: "Second")
        expectNear(lookup(out, "Metric", "Hour"), 1.0)
        expectNear(lookup(out, "Scientific", "Kilosecond"), 3.6)
    }

    @Test func speedWithinAndCross() {
        let cat = Speed(name: "MeterPerSecond")
        let out = cat.convertedValues(value: 1.0, from: "MeterPerSecond")
        expectNear(lookup(out, "Metric", "KilometerPerHour"), 3.6)
        expectNear(lookup(out, "Nautical", "Knot"), 1.0 / 0.514444)
    }

    @Test func torqueWithinAndCross() {
        let cat = Torque(name: "NewtonMeter")
        let out = cat.convertedValues(value: 1.35582, from: "NewtonMeter")
        expectNear(lookup(out, "Imperial", "PoundFoot"), 1.0)
        expectNear(lookup(out, "Imperial", "PoundInch"), 12.0)
    }

    @Test func frequencyWithinAndCross() {
        let cat = Frequency(name: "Hertz")
        let out = cat.convertedValues(value: 1.0, from: "Hertz")
        expectNear(lookup(out, "Metric", "Kilohertz"), 0.001)
        expectNear(lookup(out, "Scientific", "RadianPerSecond"), 2 * Double.pi)
    }

    // MARK: - Phase 3 round-trips (10 new categories)

    @Test func acousticRoundTripAndReference() {
        let cat = Acoustic(name: "Pascal")
        let rt = cat.convertedValues(value: 0.02, from: "Pascal")
        expectNear(lookup(rt, "Metric", "Pascal"), 0.02, "Acoustic RT")
        expectNear(lookup(rt, "Scientific", "DecibelSPL"), 60.0, "0.02 Pa = 60 dB SPL")
        let fromDB = cat.convertedValues(value: 20.0 * log10(1.0 / 20e-6), from: "DecibelSPL")
        expectNear(lookup(fromDB, "Metric", "Pascal"), 1.0, "≈93.98 dB SPL = 1 Pa")
    }

    @Test func thermodynamicRoundTrip() {
        let cat = Thermodynamic(name: "Kelvin")
        let out = cat.convertedValues(value: 0.0, from: "Celsius")
        expectNear(lookup(out, "Metric", "Kelvin"), 273.15)
        expectNear(lookup(out, "Imperial", "Fahrenheit"), 32.0)
        let back = cat.convertedValues(value: 212.0, from: "Fahrenheit")
        expectNear(lookup(back, "Metric", "Celsius"), 100.0)
    }

    @Test func electromagneticRoundTrip() {
        let cat = Electromagnetic(name: "Tesla")
        let out = cat.convertedValues(value: 1.0, from: "Tesla")
        expectNear(lookup(out, "Scientific", "Gauss"), 10000.0)
        let back = cat.convertedValues(value: 5.0, from: "Gauss")
        expectNear(lookup(back, "Metric", "Tesla"), 5e-4)
    }

    @Test func chemicalRoundTrip() {
        let cat = Chemical(name: "PascalSecond")
        let visc = cat.convertedValues(value: 1.0, from: "Centipoise")
        expectNear(lookup(visc, "Metric", "MillipascalSecond"), 1.0)
        expectNear(lookup(visc, "Imperial", "Centipoise"), 1.0)
        let conc = cat.convertedValues(value: 2.0, from: "MolPerLiter")
        expectNear(lookup(conc, "Scientific", "MillimolPerLiter"), 2000.0)
    }

    @Test func hydrodynamicRoundTrip() {
        let cat = Hydrodynamic(name: "LiterPerSecond")
        let out = cat.convertedValues(value: 1.0, from: "LiterPerSecond")
        expectNear(lookup(out, "Metric", "CubicMeterPerSecond"), 0.001)
        expectNear(lookup(out, "Imperial", "GallonPerMinute"), 0.001 / (3.78541e-3 / 60.0))
        let mass = cat.convertedValues(value: 1.0, from: "KilogramPerSecond")
        expectNear(lookup(mass, "Scientific", "GramPerSecond"), 1000.0)
    }

    @Test func matterRoundTrip() {
        let cat = Matter(name: "Mole")
        let out = cat.convertedValues(value: 1.0, from: "Mole")
        expectNear(lookup(out, "Metric", "Millimole"), 1000.0)
        expectNear(lookup(out, "Scientific", "ParticleCount"), 6.02214076e23)
    }

    @Test func environmentalRoundTrip() {
        let cat = Environmental(name: "Millimeter")
        let out = cat.convertedValues(value: 25.4, from: "Millimeter")
        expectNear(lookup(out, "Imperial", "Inch"), 1.0)
        let hum = cat.convertedValues(value: 5.0, from: "GramPerCubicMeter")
        expectNear(lookup(hum, "Scientific", "KilogramPerCubicMeter"), 0.005)
    }

    @Test func aerodynamicRoundTrip() {
        let cat = Aerodynamic(name: "Pascal")
        let p = cat.convertedValues(value: 1.0, from: "Psi")
        expectNear(lookup(p, "Metric", "Pascal"), 6894.76)
        let speed = cat.convertedValues(value: 1.0, from: "Mach")
        expectNear(lookup(speed, "Scientific", "MeterPerSecond"), 343.0)
        expectNear(lookup(speed, "Scientific", "Mach"), 1.0)
    }

    @Test func biologicalRoundTrip() {
        let cat = Biological(name: "BeatsPerMinute")
        let out = cat.convertedValues(value: 60.0, from: "BeatsPerMinute")
        expectNear(lookup(out, "Metric", "PerSecond"), 1.0)
        expectNear(lookup(out, "Scientific", "BeatsPerMinute"), 60.0)
    }

    @Test func perceptualRoundTrip() {
        let cat = Perceptual(name: "BitPerSecond")
        let out = cat.convertedValues(value: 1.0, from: "MebibytePerSecond")
        expectNear(lookup(out, "Metric", "BitPerSecond"), 8.0 * 1024.0 * 1024.0)
        expectNear(lookup(out, "Imperial", "MebibytePerSecond"), 1.0)
        let k = cat.convertedValues(value: 6500.0, from: "Kelvin")
        expectNear(lookup(k, "Scientific", "Kelvin"), 6500.0)
    }

    @Test func tabModelRegistersSixtyTwoCategories() {
        #expect(TabItem.tabs.count == 62)
        let titles = TabItem.tabs.map(\.title)
        #expect(titles.contains("Length"))
        #expect(titles.contains("Time"))
        #expect(titles.contains("Perceptual"))
        #expect(titles.contains("Temperature"))
        #expect(titles.contains("Baud Rate"))
        #expect(!titles.contains(where: { $0 == "square" || $0 == "Square" }))
    }

    // MARK: - Phase 4 flat-list quantities (33 new tabs)

    @Test func temperatureAffineConversion() {
        let cat = Temperature(name: "Celsius")
        let out = cat.convertedValues(value: 0.0, from: "Celsius")
        expectNear(lookup(out, "Metric", "Kelvin"), 273.15)
        expectNear(lookup(out, "Imperial", "Fahrenheit"), 32.0)
        let boiling = cat.convertedValues(value: 212.0, from: "Fahrenheit")
        expectNear(lookup(boiling, "Metric", "Celsius"), 100.0)
    }

    @Test func fuelEconomyReciprocalConversion() {
        let cat = FuelEconomy(name: "MilesPerGallonUS")
        let out = cat.convertedValues(value: 25.0, from: "MilesPerGallonUS")
        expectNear(lookup(out, "Metric", "LitersPer100Km"), 100.0 / (25.0 * 1.609344 / 3.785411784))
        let fromMetric = cat.convertedValues(value: 8.0, from: "LitersPer100Km")
        expectNear(lookup(fromMetric, "Imperial", "MilesPerGallonUS"), (100.0 / 8.0) * 3.785411784 / 1.609344)
    }

    @Test func threadPitchInverseConversion() {
        let cat = ThreadPitch(name: "ThreadsPerInch")
        let out = cat.convertedValues(value: 20.0, from: "ThreadsPerInch")
        expectNear(lookup(out, "Metric", "MillimeterPitch"), 25.4 / 20.0)
        let back = cat.convertedValues(value: 1.25, from: "MillimeterPitch")
        expectNear(lookup(back, "Imperial", "ThreadsPerInch"), 25.4 / 1.25)
    }

    @Test func digitalStorageDecimalVsBinary() {
        let cat = DigitalStorage(name: "Megabyte")
        let dec = cat.convertedValues(value: 1.0, from: "Megabyte")
        expectNear(lookup(dec, "Metric", "Byte"), 1e6)
        expectNear(lookup(dec, "Imperial", "Mebibyte"), 1e6 / (1024.0 * 1024.0))
        let bin = cat.convertedValues(value: 1.0, from: "Mebibyte")
        expectNear(lookup(bin, "Metric", "Byte"), 1024.0 * 1024.0)
    }

    @Test func radioactivityAndRadiationUnits() {
        let cat = Radioactivity(name: "Becquerel")
        let out = cat.convertedValues(value: 1.0, from: "Curie")
        expectNear(lookup(out, "Metric", "Becquerel"), 3.7e10)
        let dose = AbsorbedDose(name: "Gray")
        let rad = dose.convertedValues(value: 100.0, from: "Rad")
        expectNear(lookup(rad, "Metric", "Gray"), 1.0)
        let sv = EquivalentDose(name: "Sievert")
        let rem = sv.convertedValues(value: 1.0, from: "Rem")
        expectNear(lookup(rem, "Metric", "Sievert"), 0.01)
        let exp = Exposure(name: "Roentgen")
        let roentgen = exp.convertedValues(value: 1.0, from: "Roentgen")
        expectNear(lookup(roentgen, "Metric", "CoulombPerKilogram"), 2.58e-4)
    }

    @Test func informationEntropyLogConversion() {
        let cat = InformationEntropy(name: "Bit")
        let out = cat.convertedValues(value: 1.0, from: "Bit")
        expectNear(lookup(out, "Metric", "Shannon"), 1.0)
        expectNear(lookup(out, "Scientific", "Nat"), 1.0 / log2(M_E))
        let back = cat.convertedValues(value: 1.0 / log2(M_E), from: "Nat")
        expectNear(lookup(back, "Metric", "Bit"), 1.0)
    }

    @Test func concentrationWaterAssumption() {
        let cat = Concentration(name: "PartsPerMillion")
        let out = cat.convertedValues(value: 10.0, from: "PartsPerMillion")
        expectNear(lookup(out, "Metric", "MilligramPerLiter"), 10.0)
        expectNear(lookup(out, "Metric", "PartsPerBillion"), 10000.0)
    }
}
