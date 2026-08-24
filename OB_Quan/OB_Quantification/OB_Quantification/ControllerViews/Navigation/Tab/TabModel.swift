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
//        Temperature
        TabItem(id: UUID(), title: "Temperature", systemImage: "thermometer.medium", currentPage: "Temperature", status: "Active", isExportable: true, category: Temperature(name: "Celsius")),
//        DigitalStorage
        TabItem(id: UUID(), title: "Digital Storage", systemImage: "internaldrive", currentPage: "Digital Storage", status: "Active", isExportable: true, category: DigitalStorage(name: "Byte")),
//        DataTransferRate
        TabItem(id: UUID(), title: "Data Transfer Rate", systemImage: "arrow.up.arrow.down.circle", currentPage: "Data Transfer Rate", status: "Active", isExportable: true, category: DataTransferRate(name: "MegabitPerSecond")),
//        FuelEconomy
        TabItem(id: UUID(), title: "Fuel Economy", systemImage: "fuelpump", currentPage: "Fuel Economy", status: "Active", isExportable: true, category: FuelEconomy(name: "MilesPerGallonUS")),
//        ScreenResolution
        TabItem(id: UUID(), title: "Screen Resolution", systemImage: "display", currentPage: "Screen Resolution", status: "Active", isExportable: true, category: ScreenResolution(name: "PixelsPerInch")),
//        ThreadPitch
        TabItem(id: UUID(), title: "Thread Pitch", systemImage: "screwdriver", currentPage: "Thread Pitch", status: "Active", isExportable: true, category: ThreadPitch(name: "ThreadsPerInch")),
//        PrecisionLength
        TabItem(id: UUID(), title: "Precision Length", systemImage: "ruler.fill", currentPage: "Precision Length", status: "Active", isExportable: true, category: PrecisionLength(name: "Micron")),
//        CuttingSpeed
        TabItem(id: UUID(), title: "Cutting Speed", systemImage: "gearshape.2", currentPage: "Cutting Speed", status: "Active", isExportable: true, category: CuttingSpeed(name: "SurfaceFeetPerMinute")),
//        FeedRate
        TabItem(id: UUID(), title: "Feed Rate", systemImage: "arrow.right.to.line", currentPage: "Feed Rate", status: "Active", isExportable: true, category: FeedRate(name: "InchPerMinute")),
//        RotationalSpeed
        TabItem(id: UUID(), title: "Rotational Speed", systemImage: "rotate.3d", currentPage: "Rotational Speed", status: "Active", isExportable: true, category: RotationalSpeed(name: "RPM")),
//        SurfaceRoughness
        TabItem(id: UUID(), title: "Surface Roughness", systemImage: "waveform", currentPage: "Surface Roughness", status: "Active", isExportable: true, category: SurfaceRoughness(name: "MicrometerRa")),
//        MomentOfInertia
        TabItem(id: UUID(), title: "Moment Of Inertia", systemImage: "circle.dashed", currentPage: "Moment Of Inertia", status: "Active", isExportable: true, category: MomentOfInertia(name: "KilogramMeterSquared")),
//        LuminousFlux
        TabItem(id: UUID(), title: "Luminous Flux", systemImage: "lightbulb", currentPage: "Luminous Flux", status: "Active", isExportable: true, category: LuminousFlux(name: "Lumen")),
//        LuminousIntensity
        TabItem(id: UUID(), title: "Luminous Intensity", systemImage: "light.max", currentPage: "Luminous Intensity", status: "Active", isExportable: true, category: LuminousIntensity(name: "Candela")),
//        RadiantIntensity
        TabItem(id: UUID(), title: "Radiant Intensity", systemImage: "sun.max.fill", currentPage: "Radiant Intensity", status: "Active", isExportable: true, category: RadiantIntensity(name: "WattPerSteradian")),
//        Luminance
        TabItem(id: UUID(), title: "Luminance", systemImage: "light.beacon.max", currentPage: "Luminance", status: "Active", isExportable: true, category: Luminance(name: "CandelaPerSquareMeter")),
//        DynamicViscosity
        TabItem(id: UUID(), title: "Dynamic Viscosity", systemImage: "drop.degreesign", currentPage: "Dynamic Viscosity", status: "Active", isExportable: true, category: DynamicViscosity(name: "PascalSecond")),
//        KinematicViscosity
        TabItem(id: UUID(), title: "Kinematic Viscosity", systemImage: "drop.triangle", currentPage: "Kinematic Viscosity", status: "Active", isExportable: true, category: KinematicViscosity(name: "Centistokes")),
//        VolumetricFlowRate
        TabItem(id: UUID(), title: "Volumetric Flow Rate", systemImage: "arrow.triangle.branch", currentPage: "Volumetric Flow Rate", status: "Active", isExportable: true, category: VolumetricFlowRate(name: "LiterPerMinute")),
//        MassFlowRate
        TabItem(id: UUID(), title: "Mass Flow Rate", systemImage: "arrow.down.circle", currentPage: "Mass Flow Rate", status: "Active", isExportable: true, category: MassFlowRate(name: "KilogramPerSecond")),
//        Radioactivity
        TabItem(id: UUID(), title: "Radioactivity", systemImage: "radiation", currentPage: "Radioactivity", status: "Active", isExportable: true, category: Radioactivity(name: "Becquerel")),
//        AbsorbedDose
        TabItem(id: UUID(), title: "Absorbed Dose", systemImage: "cross.case", currentPage: "Absorbed Dose", status: "Active", isExportable: true, category: AbsorbedDose(name: "Gray")),
//        EquivalentDose
        TabItem(id: UUID(), title: "Equivalent Dose", systemImage: "shield.lefthalf.filled", currentPage: "Equivalent Dose", status: "Active", isExportable: true, category: EquivalentDose(name: "Sievert")),
//        Exposure
        TabItem(id: UUID(), title: "Exposure", systemImage: "rays", currentPage: "Exposure", status: "Active", isExportable: true, category: Exposure(name: "Roentgen")),
//        Momentum
        TabItem(id: UUID(), title: "Momentum", systemImage: "arrow.left.and.right", currentPage: "Momentum", status: "Active", isExportable: true, category: Momentum(name: "KilogramMeterPerSecond")),
//        AngularMomentum
        TabItem(id: UUID(), title: "Angular Momentum", systemImage: "arrow.triangle.2.circlepath", currentPage: "Angular Momentum", status: "Active", isExportable: true, category: AngularMomentum(name: "KilogramMeterSquaredPerSecond")),
//        Jerk
        TabItem(id: UUID(), title: "Jerk", systemImage: "chart.line.uptrend.xyaxis", currentPage: "Jerk", status: "Active", isExportable: true, category: Jerk(name: "MeterPerSecondCubed")),
//        Impulse
        TabItem(id: UUID(), title: "Impulse", systemImage: "arrow.up.left.and.arrow.down.right", currentPage: "Impulse", status: "Active", isExportable: true, category: Impulse(name: "NewtonSecond")),
//        Concentration
        TabItem(id: UUID(), title: "Concentration", systemImage: "flask", currentPage: "Concentration", status: "Active", isExportable: true, category: Concentration(name: "PartsPerMillion")),
//        MolarMass
        TabItem(id: UUID(), title: "Molar Mass", systemImage: "atom", currentPage: "Molar Mass", status: "Active", isExportable: true, category: MolarMass(name: "GramPerMole")),
//        Molality
        TabItem(id: UUID(), title: "Molality", systemImage: "drop.halffull", currentPage: "Molality", status: "Active", isExportable: true, category: Molality(name: "MolePerKilogram")),
//        InformationEntropy
        TabItem(id: UUID(), title: "Information Entropy", systemImage: "info.circle", currentPage: "Information Entropy", status: "Active", isExportable: true, category: InformationEntropy(name: "Bit")),
//        BaudRate
        TabItem(id: UUID(), title: "Baud Rate", systemImage: "antenna.radiowaves.left.and.right", currentPage: "Baud Rate", status: "Active", isExportable: true, category: BaudRate(name: "Baud")),
    ]
}
