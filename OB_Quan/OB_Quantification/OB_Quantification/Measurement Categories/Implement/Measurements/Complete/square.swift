//
//  square.swift
//  OB_Quantification
//
//  Created by Arison on 11/26/25.
//
//  Double helpers (`.squared`, `.cubed`). Not a UnitCategory — leave out of TabModel.
//

import Foundation
extension Double {
    var squared: Double {
        return self * self}
    var cubed: Double { self * self * self }
}
