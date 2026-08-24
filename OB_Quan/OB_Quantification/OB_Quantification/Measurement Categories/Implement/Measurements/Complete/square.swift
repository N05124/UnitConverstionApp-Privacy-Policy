//
//  square.swift
//  OB_Quantification
//
//  Shared Double helpers historically used by Area/Volume.
//  Current Area.swift / Volume.swift no longer call `.squared` / `.cubed`
//  (they use true area/volume bases), but this utility file is retained for
//  compatibility and is intentionally NOT registered in TabModel — it is not
//  a UnitCategory.
//

import Foundation
extension Double {
    var squared: Double {
        return self * self}
    var cubed: Double { self * self * self }
}
