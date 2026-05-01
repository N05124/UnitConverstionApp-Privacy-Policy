//
//  OB_QuantificationApp.swift
//  OB_Quantification
//
//  Created by Arison on 11/5/25.
//

import SwiftUI

@main
struct OB_QuantificationApp: App {
    var body: some Scene {
        WindowGroup {
            
            
            // Pass instances into ContentView
            ContentView(
                model: NavBarModel()
            )
        }
    }
}

