//
//  Collapsible_Section.swift
//  OB_Quantification
//
//  Created by Arison on 11/10/25.
//

import Foundation
import SwiftUI

struct CollapsibleSection: View {
    var title: String
    var units: [String]
    
    // Binding to selected unit from parent
    @Binding var selectedUnit: String?
    
    var body: some View {
        DisclosureGroup(title) {
            VStack(alignment: .leading, spacing: 8) {
                ForEach(Array(units.enumerated()), id: \.offset) { index, unit in
                    Button(action: {
                        selectedUnit = unit
                    }) {
                        HStack {
                            Text("\(index + 1). \(unit)") // enumerated for readability
                                .foregroundColor(.primary)
                            if selectedUnit == unit {
                                Spacer()
                                Image(systemName: "checkmark")
                                    .foregroundColor(.blue)
                            }
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .padding(.leading)
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    // Use @State inside a container view for the preview
    @Previewable @State var selectedUnit: String? = nil

            CollapsibleSection(title: "Imperial", units: ["inches", "centimeters"], selectedUnit: $selectedUnit)
        
}
