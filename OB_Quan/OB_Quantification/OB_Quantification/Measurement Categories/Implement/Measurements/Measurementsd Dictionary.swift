//
//  Measurementsd Dictionary.swift
//  OB_Quantification
//
//  Living checklist of measurement-category coverage for the OB_Quantification app.
//
//  STATE (verification pass):
//  - Fully implemented & registered (convertible SI/customary units):
//      Length, Volume, Area, Weight, Liquid, Angle, Acceleration, Density,
//      Electricity, Energy, Force, Power, Illumination, Saturation, Pressure,
//      Time (Temporal), Speed, Torque, Frequency,
//      Acoustic, Thermodynamic, Electromagnetic, Chemical, Hydrodynamic,
//      Matter, Environmental, Aerodynamic, Biological, Perceptual
//  - Intentionally skipped as standalone categories (de-duplicated):
//      Spatial → Length/Area/Volume/Angle
//      Energy / Motion → Force/Energy/Speed/Acceleration/Torque/Power/Weight
//  - Intentionally skipped (needs external calibration / not a unit conversion):
//      Other / Additional metrics (ROI, AQI composites, Cp/Cpk, NDVI, HDI,
//      PSNR/SSIM, MTBF context scores, etc.)
//  - TODO'd inline inside specific category files (not in unit arrays):
//      STI/MOS/Clarity (Acoustic), IC50/CFU/OD (Biological), hardness/octane
//      (Chemical), Re/Fr/Cd (Hydrodynamic), Cp/flutter (Aerodynamic),
//      AQI (Environmental), Likert/sones/perplexity (Perceptual), etc.
//

import Foundation

/*
 MEASUREMENT CATEGORY CHECKLIST
 ==============================

 Acoustic
   // IMPLEMENTED — see Acoustic.swift (sound pressure / dB SPL)
   // TODO: not a convertible unit — requires reference calibration data:
   //   STI, Clarity C50/C80, MOS, weighted Leq without spectrum, harmonics maps

 Biological
   // IMPLEMENTED — see Biological.swift (event rates: bpm / breaths)
   // TODO: not a convertible unit — requires reference calibration data:
   //   IC50/EC50/LD50, RPKM/TPM, CFU, biodiversity indices, OD without ε·ℓ

 Chemical / Material
   // IMPLEMENTED — see Chemical.swift (dynamic viscosity, molar concentration)
   // TODO: not a convertible unit — requires reference calibration data:
   //   Mohs/Vickers/Rockwell, octane/cetane, K_ow without standard mapping

 Electromagnetic
   // IMPLEMENTED — see Electromagnetic.swift (magnetic flux density B)
   // Voltage/current/resistance/capacitance/inductance → Electricity.swift
   // Electrical power → Power.swift

 Energy / Motion
   // IMPLEMENTED — covered by existing Force.swift, Energy.swift, Speed.swift,
   //   Acceleration.swift, Torque.swift, Power.swift, Weight.swift
   // (no separate EnergyMotion.swift — de-duplicated)

 Environmental
   // IMPLEMENTED — see Environmental.swift (precipitation depth, absolute humidity)
   // Temperature → Thermodynamic.swift; RH → Saturation.swift;
   //   pressure → Pressure.swift; wind → Speed.swift
   // TODO: not a convertible unit — requires reference calibration data:
   //   AQI (regional breakpoints), chlorophyll relative fluorescence

 Matter
   // IMPLEMENTED — see Matter.swift (amount of substance / particle count)
   // Density → Density.swift
   // TODO: not a convertible unit — requires reference calibration data:
   //   lattice constants without cell params, porosity without density pair

 Perceptual / Informational
   // IMPLEMENTED — see Perceptual.swift (bit rate, color temperature K)
   // TODO: not a convertible unit — requires reference calibration data:
   //   MOS, Likert, JND, sones (spectrum-dependent), perplexity

 Spatial
   // IMPLEMENTED — covered by Length.swift, Area.swift, Volume.swift, Angle.swift
   // (no separate Spatial.swift — de-duplicated)

 Temporal
   // IMPLEMENTED — see Implement/Temporal.swift

 Thermodynamic
   // IMPLEMENTED — see Thermodynamic.swift (temperature scales)
   // Pressure → Pressure.swift; heat energy → Energy.swift
   // TODO: not a convertible unit — requires reference calibration data:
   //   equilibrium constants K, chemical potential with composition

 Hydrodynamic
   // IMPLEMENTED — see Hydrodynamic.swift (volumetric + mass flow)
   // TODO: not a convertible unit without fluid context:
   //   Re, Fr, St, Cd, Cl

 Aerodynamic
   // IMPLEMENTED — see Aerodynamic.swift (dynamic pressure, airspeed / Mach@ISA)
   // TODO: not a convertible unit without freestream context:
   //   Cp, aeroelastic flutter frequency

 Other / Additional metrics
   // TODO: not a convertible unit — requires reference calibration data:
   //   economic/ROI, TLV/PEL, Cp/Cpk, NDVI, HDI/CPI, PSNR/SSIM composites,
   //   MTBF context-specific reliability scores
*/
