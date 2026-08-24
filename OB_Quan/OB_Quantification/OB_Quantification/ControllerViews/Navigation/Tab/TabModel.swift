//
//  TabModel.swift
//  OB_Quantification
//
//  Created by Arison on 11/7/25.
//

import Foundation
// MARK: - Tab Data Model
struct TabItem: Identifiable{
    let id:UUID
    let title: String
    let systemImage: String
    let currentPage: String
    let status: String
    let isExportable: Bool
    let category: any UnitCategory //    let content: any View
    
    
    static let tabs: [TabItem] = [
//        Length
        TabItem(id: UUID(), title: "Length", systemImage: "ruler", currentPage: "Length", status: "Active", isExportable: true, category: Length(name: "Meters")),
//        Volume
        TabItem(id: UUID(), title: "Volume", systemImage: "cube", currentPage: "Volume", status: "Active", isExportable: true, category: Volume(name: "Meters")),
//        Area
        TabItem(id: UUID(), title: "Area", systemImage: "square.split.2x2", currentPage: "Area", status: "Active", isExportable: true, category: Area(name: "Meters")),
//        Weight
        TabItem(id: UUID(), title: "Weight", systemImage: "scalemass", currentPage: "Weight", status: "In Progress", isExportable: true, category: Weight(name: "Meters")),
//        LiquidVolume
        TabItem(id: UUID(), title: "Liquid", systemImage: "drop.circle", currentPage: "Liquid Vol", status: "In Progress", isExportable: true, category: LiquidVolume(name: "Liters")),
//        Angle
        TabItem(id: UUID(), title: "Angle", systemImage: "arrow.turn.right.up", currentPage: "Angles", status: "In Progress", isExportable: true, category: Angle(name: "Radian")),
//        Acceleration
        TabItem(id: UUID(), title: "Acceleration", systemImage: "speedometer", currentPage: "Acceleration", status: "In Progress", isExportable: true, category: Acceleration(name: "Millimeter Per Second Squared")),
//        Density
        TabItem(id: UUID(), title: "Density", systemImage: "cube.box", currentPage: "Density", status: "In Progress", isExportable: true, category: Density(name: "Gram Per Cubic Meter")),
//        Electricity
        TabItem(id: UUID(), title: "Electricity", systemImage: "bolt.fill", currentPage: "Electricity", status: "In Progress", isExportable: true, category: Electricity(name: "Ampere")),
//        Energy
        TabItem(id: UUID(), title: "Energy", systemImage: "diamond", currentPage: "Energy", status: "In Progress", isExportable: true, category: Energy(name: "Joule")),
//        Force
        TabItem(id: UUID(), title: "Force", systemImage: "dial.high", currentPage: "Force", status: "In Progress", isExportable: true, category: Force(name: "Newtons")),
//        Power
        TabItem(id: UUID(), title: "Power", systemImage: "bolt.circle", currentPage: "Power", status: "Active", isExportable: true, category: Power(name: "Watt")),
//        Illumination
        TabItem(id: UUID(), title: "Illumination", systemImage: "sun.max", currentPage: "Illumination", status: "Active", isExportable: true, category: Illumination(name: "Lux")),
//        Saturation
        TabItem(id: UUID(), title: "Saturation", systemImage: "percent", currentPage: "Saturation", status: "Active", isExportable: true, category: Saturation(name: "Percent")),
//        Pressure
        TabItem(id: UUID(), title: "Pressure", systemImage: "barometer", currentPage: "Pressure", status: "Active", isExportable: true, category: Pressure(name: "Pascal")),
//        Temporal
        TabItem(id: UUID(), title: "Time", systemImage: "clock", currentPage: "Time", status: "Active", isExportable: true, category: Temporal(name: "Second")),
//        Speed
        TabItem(id: UUID(), title: "Speed", systemImage: "gauge", currentPage: "Speed", status: "Active", isExportable: true, category: Speed(name: "MeterPerSecond")),
//        Torque
        TabItem(id: UUID(), title: "Torque", systemImage: "arrow.2.circlepath", currentPage: "Torque", status: "Active", isExportable: true, category: Torque(name: "NewtonMeter")),
//        Frequency
        TabItem(id: UUID(), title: "Frequency", systemImage: "waveform.path", currentPage: "Frequency", status: "Active", isExportable: true, category: Frequency(name: "Hertz")),
//        Acoustic
        TabItem(id: UUID(), title: "Acoustic", systemImage: "ear", currentPage: "Acoustic", status: "In Progress", isExportable: true, category: Acoustic(name: "Pascal")),
//        Thermodynamic
        TabItem(id: UUID(), title: "Thermodynamic", systemImage: "thermometer", currentPage: "Thermodynamic", status: "In Progress", isExportable: true, category: Thermodynamic(name: "Kelvin")),
//        Electromagnetic
        TabItem(id: UUID(), title: "Electromagnetic", systemImage: "dot.radiowaves.left.and.right", currentPage: "Electromagnetic", status: "In Progress", isExportable: true, category: Electromagnetic(name: "Tesla")),
//        Chemical
        TabItem(id: UUID(), title: "Chemical", systemImage: "testtube.2", currentPage: "Chemical", status: "In Progress", isExportable: true, category: Chemical(name: "PascalSecond")),
//        Hydrodynamic
        TabItem(id: UUID(), title: "Hydrodynamic", systemImage: "wind", currentPage: "Hydrodynamic", status: "In Progress", isExportable: true, category: Hydrodynamic(name: "LiterPerSecond")),
//        Matter
        TabItem(id: UUID(), title: "Matter", systemImage: "circle.hexagongrid", currentPage: "Matter", status: "In Progress", isExportable: true, category: Matter(name: "Mole")),
//        Environmental
        TabItem(id: UUID(), title: "Environmental", systemImage: "cloud.rain", currentPage: "Environmental", status: "In Progress", isExportable: true, category: Environmental(name: "Millimeter")),
//        Aerodynamic
        TabItem(id: UUID(), title: "Aerodynamic", systemImage: "airplane", currentPage: "Aerodynamic", status: "In Progress", isExportable: true, category: Aerodynamic(name: "Pascal")),
//        Biological
        TabItem(id: UUID(), title: "Biological", systemImage: "heart", currentPage: "Biological", status: "In Progress", isExportable: true, category: Biological(name: "BeatsPerMinute")),
//        Perceptual
        TabItem(id: UUID(), title: "Perceptual", systemImage: "eye", currentPage: "Perceptual", status: "In Progress", isExportable: true, category: Perceptual(name: "BitPerSecond")),
    ]
}
