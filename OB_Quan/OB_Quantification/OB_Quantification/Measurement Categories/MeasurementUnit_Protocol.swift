//
//  MeasurementUnit_Protocol.swift
//  OB_Quantification
//
//  Created by Arison on 11/10/25.
//

import Foundation

// MARK: - Protocol (optional)
protocol UnitCategory {
    var currentPage: String { get }
    var status: String { get }
    var isExportable: Bool { get }
    var name: String { get }
    var imperial: [String] { get }
    var metric: [String] { get }
    var scientific: [String] { get }
    var nautical: [String] { get }
    
    // Function to convert from a unit to all units in this category
    func convertedValues(value: Double, from unit: String) -> [String:[String: Double]]

}
