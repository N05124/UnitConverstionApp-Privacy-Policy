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
    
    // MARK: - Dynamic Conversion Logic
    func convertedValues(value: Double, from unit: String) -> [String:[String: Double]] {
        // Determine the unit type and call the corresponding conversion
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
    
    // MARK: - Conversion helpers
    
    private func convertFromMetric(_ value: Double, unit: String) -> [String:[String: Double]] {
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
        let toImperial = toMeters / 0.0254
        let toNautical = toImperial
        let toScientific = toMeters
        
        var result = mergeMetricValues(toMeters)
        result.merge(mergeImperialValues(toImperial)) { current, _ in current }
        result.merge(mergeNauticalValues(toNautical)) { current, _ in current }
        result.merge(mergeScientificValues(toScientific)) { current, _ in current }
        return result
    }
    
    private func convertFromImperial(_ value: Double, unit: String) -> [String:[String: Double]] {
        let toInches: Double
        switch unit {
        case "Inch": toInches = value
        case "Foot": toInches = value * 12
        case "Yard": toInches = value * 36
        case "Chain": toInches = value * 792
        case "Furlong": toInches = value * 7920
        case "Mile": toInches = value * 63360
        case "League": toInches = value * 190080
        default: toInches = value
        }
        let toMeters = toInches * 0.0254
        let toNautical = toInches
        let toScientific = toMeters
        
        var result = mergeImperialValues(toInches)
        result.merge(mergeMetricValues(toMeters)) { current, _ in current }
        result.merge(mergeNauticalValues(toNautical)) { current, _ in current }
        result.merge(mergeScientificValues(toScientific)) { current, _ in current }
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
        let toMeters = toInches * 0.0254
        let toImperial = toInches
        let toScientific = toMeters
        
        var result = mergeNauticalValues(toInches)
        result.merge(mergeImperialValues(toImperial)) { current, _ in current }
        result.merge(mergeMetricValues(toMeters)) { current, _ in current }
        result.merge(mergeScientificValues(toScientific)) { current, _ in current }
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
        let toImperial = toMeters / 0.0254
        let toNautical = toImperial
        
        var result = mergeScientificValues(toMeters)
        result.merge(mergeImperialValues(toImperial)) { current, _ in current }
        result.merge(mergeMetricValues(toMeters)) { current, _ in current }
        result.merge(mergeNauticalValues(toNautical)) { current, _ in current }
        return result
    }
    
    // MARK: - Merge Dictionaries (Cubed!)
    private func mergeMetricValues(_ value: Double) -> [String:[String: Double]] {
        var dict: [String:[String: Double]] = [:]
        dict["Metric"] = [
            "Millimeter³": (value * 1000).cubed,
            "Centimeter³": (value * 100).cubed,
            "Meter³": value.cubed,
            "Decameter³": (value / 10).cubed,
            "Hectometer³": (value / 100).cubed,
            "Kilometer³": (value / 1000).cubed,
            "Megameter³": (value / 1e6).cubed,
            "Gigameter³": (value / 1e9).cubed,
            "Terameter³": (value / 1e12).cubed,
            "Petameter³": (value / 1e15).cubed,
            "Exameter³": (value / 1e18).cubed,
            "Zettameter³": (value / 1e21).cubed,
            "Yottameter³": (value / 1e24).cubed
        ]
        return dict
    }
    
    private func mergeImperialValues(_ value: Double) -> [String:[String: Double]] {
        var dict: [String:[String: Double]] = [:]
        dict["Imperial"] = [
            "Inch³": value.cubed,
            "Foot³": (value / 12.0).cubed,
            "Yard³": (value / 36.0).cubed,
            "Chain³": (value / 792.0).cubed,
            "Furlong³": (value / 7920.0).cubed,
            "Mile³": (value / 63360.0).cubed,
            "League³": (value / 190080.0).cubed
        ]
        return dict
    }
    
    private func mergeNauticalValues(_ value: Double) -> [String:[String: Double]] {
        var dict: [String:[String: Double]] = [:]
        dict["Nautical"] = [
            "Inch³": value.cubed,
            "Foot³": (value / 12.0).cubed,
            "Yard³": (value / 36.0).cubed,
            "Fathom³": (value / 72.0).cubed,
            "Cable³": (value / 6076.1).cubed,
            "NauticalMile³": (value / 72913.4).cubed
        ]
        return dict
    }
    
    private func mergeScientificValues(_ value: Double) -> [String:[String: Double]] {
        var dict: [String:[String: Double]] = [:]
        dict["Scientific"] = [
            "Yoctometer³": (value * 1e24).cubed,
            "Zeptometer³": (value * 1e21).cubed,
            "Attometer³": (value * 1e18).cubed,
            "Femtometer³": (value * 1e15).cubed,
            "Picometer³": (value * 1e12).cubed,
            "Nanometer³": (value * 1e9).cubed,
            "Micrometer³": (value * 1e6).cubed,
            "Meter³": value.cubed,
            "AstronomicalUnit³": (value / 1.496e11).cubed,
            "LunarDistance³": (value / 3.844e8).cubed,
            "LightSecond³": (value / 2.998e8).cubed,
            "LightMinute³": (value / 1.799e10).cubed,
            "LightHour³": (value / 1.079e12).cubed,
            "LightDay³": (value / 2.590e13).cubed,
            "LightYear³": (value / 9.461e15).cubed,
            "Parsec³": (value / 3.086e16).cubed,
            "Kiloparsec³": (value / 3.086e19).cubed,
            "Megaparsec³": (value / 3.086e22).cubed,
            "Gigaparsec³": (value / 3.086e25).cubed
        ]
        return dict
    }
}
