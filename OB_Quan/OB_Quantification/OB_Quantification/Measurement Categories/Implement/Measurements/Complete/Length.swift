import Foundation

struct Length: UnitCategory {
    var name: String
    let currentPage = "Length"
    let status = "Waiting"
    let isExportable = true
    
    let metric = [
      "Millimeter", "Centimeter", "Meter", "Decameter", "Hectometer",
      "Kilometer", "Megameter", "Gigameter", "Terameter", "Petameter",
      "Exameter", "Zettameter", "Yottameter"
    ];

    let imperial = [
      "Inch", "Foot", "Yard", "Chain", "Furlong", "Mile", "League"
    ];

    let scientific = [
      "Yoctometer", "Zeptometer", "Attometer", "Femtometer", "Picometer",
      "Nanometer", "Micrometer", "Meter",
      "AstronomicalUnit", "LunarDistance",
      "LightSecond", "LightMinute", "LightHour", "LightDay",
      "LightYear", "Parsec", "Kiloparsec",
      "Megaparsec", "Gigaparsec"
    ];

    let nautical = [
      "Inch", "Foot", "Yard", "Fathom", "Cable", "NauticalMile"
    ];
    
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
        let toNautical = toInches // mergeNauticalValues expects inches
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
        // 1 international cable = 1/10 nautical mile = 185.2 m = 7291.34 in
        // (not 6076.1, which is feet per nautical mile)
        case "Cable": toInches = value * 7291.34
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
            "Inch": value,
            "Foot": value / 12.0,
            "Yard": value / 36.0,
            "Fathom": value / 72.0,
            // 1 international cable = 1/10 nmi = 185.2 m = 7291.34 in
            "Cable": value / 7291.34,
            "NauticalMile": value / 72913.4
        ]
        return dict
    }
    
    private func mergeImperialValues(_ value: Double) -> [String:[String: Double]] {
        var dict: [String:[String: Double]] = [:]
        dict["Imperial"] = [
            "Inch": value,
            "Foot": value / 12.0,
            "Yard": value / 36.0,
            "Chain": value / 792.0,
            "Furlong": value / 7920.0,
            "Mile": value / 63360.0,
            "League": value / 190080.0
        ]
        return dict
    }
    
    private func mergeMetricValues(_ value: Double) -> [String:[String: Double]] {
        var dict: [String:[String: Double]] = [:]
        dict["Metric"] = [
            "Millimeter": value * 1000,
            "Centimeter": value * 100,
            "Meter": value,
            "Decameter": value / 10,
            "Hectometer": value / 100,
            "Kilometer": value / 1000,
            "Megameter": value / 1e6,
            "Gigameter": value / 1e9,
            "Terameter": value / 1e12,
            "Petameter": value / 1e15,
            "Exameter": value / 1e18,
            "Zettameter": value / 1e21,
            "Yottameter": value / 1e24
        ]
        return dict
    }
    
    private func mergeScientificValues(_ value: Double) -> [String:[String: Double]] {
        var dict: [String:[String: Double]] = [:]
        dict["Scientific"] = [
            "Yoctometer": value * 1e24,
            "Zeptometer": value * 1e21,
            "Attometer": value * 1e18,
            "Femtometer": value * 1e15,
            "Picometer": value * 1e12,
            "Nanometer": value * 1e9,
            "Micrometer": value * 1e6,
            "Meter": value,
            "AstronomicalUnit": value / 1.496e11,
            "LunarDistance": value / 3.844e8,
            "LightSecond": value / 2.998e8,
            "LightMinute": value / 1.799e10,
            "LightHour": value / 1.079e12,
            "LightDay": value / 2.590e13,
            "LightYear": value / 9.461e15,
            "Parsec": value / 3.086e16,
            "Kiloparsec": value / 3.086e19,
            "Megaparsec": value / 3.086e22,
            "Gigaparsec": value / 3.086e25
        ]
        return dict
    }
    //End Length Structure
}
