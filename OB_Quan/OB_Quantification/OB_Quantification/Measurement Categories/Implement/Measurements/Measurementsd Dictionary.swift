//
//  Measurementsd Dictionary.swift
//  OB_Quantification
//
//  Living checklist of measurement category coverage.
//  Do not delete this file — update status as categories ship.
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

// Retained as a commented reference snapshot of the original brainstorm dictionary.
// Categories above supersede this block for implementation status.
//let measurements: [String: [String: [String: String]]] = [
//    "Acoustic": [ /* see Acoustic.swift */ ],
//    "Biological": [ /* see Biological.swift */ ],
//    "Chemical / Material": [ /* see Chemical.swift */ ],
//    "Electromagnetic": [ /* see Electromagnetic.swift */ ],
//    "Energy / Motion": [ /* de-duped → Force/Energy/Speed/… */ ],
//    "Environmental": [ /* see Environmental.swift */ ],
//    "Matter": [ /* see Matter.swift */ ],
//    "Perceptual / Informational": [ /* see Perceptual.swift */ ],
//    "Spatial": [ /* de-duped → Length/Area/Volume/Angle */ ],
//    "Temporal": [ /* see Temporal.swift */ ],
//    "Thermodynamic": [ /* see Thermodynamic.swift */ ],
//    "Hydrodynamic": [ /* see Hydrodynamic.swift */ ],
//    "Aerodynamic": [ /* see Aerodynamic.swift */ ],
//    "Other / Additional metrics": [ /* TODO — non-convertible composites */ ]
//]
