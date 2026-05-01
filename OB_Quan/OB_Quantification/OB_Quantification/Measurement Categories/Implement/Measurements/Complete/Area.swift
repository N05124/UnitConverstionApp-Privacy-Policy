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
    
    // MARK: - Internal Conversion Handlers
    private func convertFromMetric(_ value: Double, unit: String) -> [String:[String: Double]]{
        let toMeters: Double
        switch unit {
        case "Millimeter": toMeters = value / 1000
        case "Centimeter": toMeters = value / 100
        case "Meter": toMeters = value
        case "Decameter": toMeters = value * 10
        case "Hectometer": toMeters = value * 100
        case "Kilometer": toMeters = value * 1000
        case "Megameter": toMeters = value * 1e6
        case "Gigameter": toMeters = value * 1e9
        case "Terameter": toMeters = value * 1e12
        case "Petameter": toMeters = value * 1e15
        case "Exameter": toMeters = value * 1e18
        case "Zettameter": toMeters = value * 1e21
        case "Yottameter": toMeters = value * 1e24
        default: toMeters = value
        }
        // normalize values for conversion
        let toImperial = toMeters / 0.0254 // meter >> inch
        let toNautical = toImperial
        let toScientific = toMeters // sci. notation

        // create mergeable dictionary
        var result = mergeMetricValues(toMeters)
        let nautical = mergeNauticalValues(toNautical)
        let imperial = mergeImperialValues(toImperial)
        let scientific = mergeScientificValues(toScientific)

        // merge dictionaries
        result.merge(imperial) { current, _ in current }
        result.merge(scientific) { current, _ in current }
        result.merge(nautical) { current, _ in current }

        // return dictionary
        return result
    }
 
    private func convertFromImperial(_ value: Double, unit: String) -> [String:[String: Double]] {
        let toInches: Double
        switch unit {
        case "Inch": toInches = value
        case "Foot": toInches = value * 12
        case "Yard": toInches = value * 36
        case "Chain": toInches = value * 792.0
        case "Furlong": toInches = value * 7920.0
        case "Mile": toInches = value * 63360.0
        case "League": toInches = value * 190080.0
        default: toInches = value
        }
        
        //normalize values for conversion
        let toMeters = toInches * 0.0254 // inch >> meter
        let toNautical = toMeters
        let toScientific = toMeters // sci. notation
        
        // create mergeable dictionary
        var result = mergeImperialValues(toInches)
        let nautical = mergeNauticalValues(toNautical)
        let metric = mergeMetricValues(toMeters)
        let scientific = mergeScientificValues(toScientific)
        // merge dictionaries
        result.merge(metric) { current, _ in current }
        result.merge(scientific) { current, _ in current }
        result.merge(nautical) { current, _ in current }
        // return dictionary
        return result
    }
    
    private func convertFromNautical(_ value: Double, unit: String) -> [String:[String: Double]] {
        let toInches: Double
        switch unit {
        case "Inch": toInches = value
        case "Foot": toInches = value * 12
        case "Yard": toInches = value * 36
        case "Fathom": toInches = value * 72
        case "Cable": toInches = value * 6076.1
        case "NauticalMile": toInches = value * 72913.4
        default: toInches = value
        }
        
        //normalize values for conversion
        let toMeters = toInches * 0.0254 // inch >> meter
        let toNautical = toInches
        let toScientific = toMeters // sci. notation
        
        // create mergeable dictionary
        var result = mergeNauticalValues(toNautical)
        let imperial = mergeImperialValues(toInches)
        let metric = mergeMetricValues(toMeters)
        let scientific = mergeScientificValues(toScientific)
        // merge dictionaries
        result.merge(metric) { current, _ in current }
        result.merge(scientific) { current, _ in current }
        result.merge(imperial) { current, _ in current }
        // return dictionary
        return result
    }
    
    private func convertFromScientific(_ value: Double, unit: String) -> [String:[String: Double]] {
        let toMeters: Double
        switch unit {
        case "Yoctometer": toMeters = value / 1e24
        case "Zeptometer": toMeters = value / 1e21
        case "Attometer": toMeters = value / 1e18
        case "Femtometer": toMeters = value / 1e15
        case "Picometer": toMeters = value / 1e12
        case "Nanometer": toMeters = value / 1e9
        case "Micrometer": toMeters = value / 1e6
        case "Meter": toMeters = value
        case "AstronomicalUnit": toMeters = value * 1.496e11
        case "LunarDistance": toMeters = value * 3.844e8
        case "LightSecond": toMeters = value * 2.998e8
        case "LightMinute": toMeters = value * 1.799e10
        case "LightHour": toMeters = value * 1.079e12
        case "LightDay": toMeters = value * 2.590e13
        case "LightYear": toMeters = value * 9.461e15
        case "Parsec": toMeters = value * 3.086e16
        case "Kiloparsec": toMeters = value * 3.086e19
        case "Megaparsec": toMeters = value * 3.086e22
        case "Gigaparsec": toMeters = value * 3.086e25
        case "Lightyear": toMeters = value * 9.461e15
        default: toMeters = value
        }
        //normalize values for conversion
        let toImperial = toMeters / 0.0254 // meter >> inch
        let toNautical = toImperial
        
        // create mergeable dictionary
        var result = mergeScientificValues(toMeters)
        let nautical = mergeNauticalValues(toNautical)
        let imperial = mergeImperialValues(toImperial)
        let metric = mergeMetricValues(toMeters)
        // merge dictionaries
        result.merge(imperial) { current, _ in current }
        result.merge(metric) { current, _ in current }
        result.merge(nautical) { current, _ in current }
        // return dictionary
        return result
    }
    
   
    private func mergeNauticalValues(_ value: Double) -> [String:[String: Double]] {
        var dict: [String:[String: Double]] = [:]
        dict["Nautical"] = [
            "Inches²": value.squared,                           // Base unit
                "Feet²": (value / 12.0).squared,                   // 12 inches in a foot
                "Yards²": (value / 36.0).squared,                  // 36 inches in a yard
                "Fathoms²": (value / 72.0).squared,                // 72 inches in a fathom
                "Cables²": (value / 6076.1).squared,               // 6076.1 feet in a cable → convert to inches first if needed
                "NauticalMiles²": (value / 72913.4).squared
        ]
        return dict
    }
    
    private func mergeImperialValues(_ value: Double) -> [String:[String: Double]] {
        var dict: [String:[String: Double]] = [:]
        dict["Imperial"] = [
            "Inches²": value.squared,
                "Feet²": (value / 12.0).squared,
                "Yards²": (value / 36.0).squared,
                "Chains²": (value / 792.0).squared,
                "Furlongs²": (value / 7920.0).squared,
                "Miles²": (value / 63360.0).squared,
                "Leagues²": (value / 190080.0).squared
        ]
        return dict
    }
    
    private func mergeMetricValues(_ value: Double) -> [String:[String: Double]] {
        var dict: [String:[String: Double]] = [:]
        dict["Metric"] = [
            "Millimeter²": (value * 1000).squared,      // 1 m = 1000 mm
                "Centimeter²": (value * 100).squared,       // 1 m = 100 cm
                "Meter²": value.squared,
                "Decameter²": (value / 10).squared,         // 1 dam = 10 m
                "Hectometer²": (value / 100).squared,      // 1 hm = 100 m
                "Kilometer²": (value / 1000).squared,      // 1 km = 1000 m
                "Megameter²": (value / 1e6).squared,
                "Gigameter²": (value / 1e9).squared,
                "Terameter²": (value / 1e12).squared,
                "Petameter²": (value / 1e15).squared,
                "Exameter²": (value / 1e18).squared,
                "Zettameter²": (value / 1e21).squared,
                "Yottameter²": (value / 1e24).squared
        ]
        return dict
    }
    
    private func mergeScientificValues(_ value: Double) -> [String:[String: Double]] {
        var dict: [String:[String: Double]] = [:]
        dict["Scientific"] = [
            "Yoctometer²": (value * 1e24).squared,
                "Zeptometer²": (value * 1e21).squared,
                "Attometer²": (value * 1e18).squared,
                "Femtometer²": (value * 1e15).squared,
                "Picometer²": (value * 1e12).squared,
                "Nanometer²": (value * 1e9).squared,
                "Micrometer²": (value * 1e6).squared,
                "Meter²": value.squared,
                "AstronomicalUnit²": (value / 1.496e11).squared,
                "LunarDistance²": (value / 3.844e8).squared,
                "LightSecond²": (value / 2.998e8).squared,
                "LightMinute²": (value / 1.799e10).squared,
                "LightHour²": (value / 1.079e12).squared,
                "LightDay²": (value / 2.590e13).squared,
                "LightYear²": (value / 9.461e15).squared,
                "Parsec²": (value / 3.086e16).squared,
                "Kiloparsec²": (value / 3.086e19).squared,
                "Megaparsec²": (value / 3.086e22).squared,
                "Gigaparsec²": (value / 3.086e25).squared
        ]
        return dict
    }
    //End Length Structure
}

