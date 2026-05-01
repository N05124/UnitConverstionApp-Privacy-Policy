import Foundation

struct Weight: UnitCategory {
    var name: String
    let currentPage = "Weight"
    let status = "In Progress"
    let isExportable = true
    
    // MARK: - Unit Categories
    let metric = [
        "Milligram", "Gram", "Kilogram", "Tonne"
    ]
    
    let imperial = [
        "Ounce", "Pound", "Stone", "Quarter", "Hundredweight", "Ton"
    ]
    
    let scientific = [
        "Microgram", "Milligram", "Gram", "Kilogram", "Megagram", "Gigagram"
    ]
    
    let nautical: [String] = ["None"] // No typical nautical weight units
    
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
    
    // MARK: - Conversion helpers
    private func convertFromMetric(_ value: Double, unit: String) -> [String:[String: Double]] {
        let toKilograms: Double
        switch unit {
        case "Milligram": toKilograms = value / 1_000_000
        case "Gram": toKilograms = value / 1000
        case "Kilogram": toKilograms = value
        case "Tonne": toKilograms = value * 1000
        default: toKilograms = value
        }
        
        let toImperial = toKilograms * 2.20462 // kg → lb
        let toScientific = toKilograms
        
        var result = mergeMetricValues(toKilograms)
        result.merge(mergeImperialValues(toImperial)) { current, _ in current }
        result.merge(mergeScientificValues(toScientific)) { current, _ in current }
        result.merge(mergeNauticalValues(toKilograms)) { current, _ in current }
        
        return result
    }
    
    private func convertFromImperial(_ value: Double, unit: String) -> [String:[String: Double]] {
        let toPounds: Double
        switch unit {
        case "Ounce": toPounds = value / 16
        case "Pound": toPounds = value
        case "Stone": toPounds = value * 14
        case "Quarter": toPounds = value * 28
        case "Hundredweight": toPounds = value * 112
        case "Ton": toPounds = value * 2240
        default: toPounds = value
        }
        
        let toKilograms = toPounds / 2.20462
        let toScientific = toKilograms
        
        var result = mergeImperialValues(toPounds)
        result.merge(mergeMetricValues(toKilograms)) { current, _ in current }
        result.merge(mergeScientificValues(toScientific)) { current, _ in current }
        result.merge(mergeNauticalValues(toKilograms)) { current, _ in current }
        
        return result
    }
    
    private func convertFromScientific(_ value: Double, unit: String) -> [String:[String: Double]] {
        let toKilograms: Double
        switch unit {
        case "Microgram": toKilograms = value / 1e9
        case "Milligram": toKilograms = value / 1e6
        case "Gram": toKilograms = value / 1000
        case "Kilogram": toKilograms = value
        case "Megagram": toKilograms = value * 1000
        case "Gigagram": toKilograms = value * 1e6
        default: toKilograms = value
        }
        
        let toImperial = toKilograms * 2.20462
        
        var result = mergeScientificValues(toKilograms)
        result.merge(mergeMetricValues(toKilograms)) { current, _ in current }
        result.merge(mergeImperialValues(toImperial)) { current, _ in current }
        result.merge(mergeNauticalValues(toKilograms)) { current, _ in current }
        
        return result
    }
    
    private func convertFromNautical(_ value: Double, unit: String) -> [String:[String: Double]] {
        return [:] // No nautical units
    }
    
    // MARK: - Merge Functions
    private func mergeMetricValues(_ value: Double) -> [String:[String: Double]] {
        var dict: [String:[String: Double]] = [:]
        dict["Metric"] = [
            "Milligram": value * 1_000_000,
            "Gram": value * 1000,
            "Kilogram": value,
            "Tonne": value / 1000
        ]
        return dict
    }
    
    private func mergeImperialValues(_ value: Double) -> [String:[String: Double]] {
        var dict: [String:[String: Double]] = [:]
        dict["Imperial"] = [
            "Ounce": value * 16,
            "Pound": value,
            "Stone": value / 14,
            "Quarter": value / 28,
            "Hundredweight": value / 112,
            "Ton": value / 2240
        ]
        return dict
    }
    
    private func mergeScientificValues(_ value: Double) -> [String:[String: Double]] {
        var dict: [String:[String: Double]] = [:]
        dict["Scientific"] = [
            "Microgram": value * 1e9,
            "Milligram": value * 1e6,
            "Gram": value * 1000,
            "Kilogram": value,
            "Megagram": value / 1000,
            "Gigagram": value / 1e6
        ]
        return dict
    }
    
    private func mergeNauticalValues(_ value: Double) -> [String:[String: Double]] {
        return [:] // No nautical weight units
    }
}
