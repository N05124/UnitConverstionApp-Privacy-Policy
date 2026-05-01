//
//  NumberPad.swift
//  OB_Quantification
//
//  Created by Arison on 11/17/25.
//

import Foundation
import SwiftUI

struct popupNumberPad: View {
    @State private var inputValue: String = ""
    @FocusState private var isEditing: Bool // Track focus for the keyboard
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                TextField("Enter Value", text: $inputValue)
                    .keyboardType(.decimalPad)      // Decimal number pad
                    .focused($isEditing)            // Attach focus state
                    .textFieldStyle(.roundedBorder)
                    .font(.title2.bold())
                    .onChange(of: inputValue) {
                        let filtered = inputValue.filter { $0.isNumber || $0 == "." }

                        let components = filtered.split(separator: ".")
                        if components.count > 1 {
                            inputValue = components[0] + "." + components[1...].joined()
                        } else {
                            inputValue = filtered
                        }
                    }
                    // Add a Done button above the keyboard
                    .toolbar {
                        ToolbarItemGroup(placement: .keyboard) {
                            Spacer()
                            Button("Done") {
                                isEditing = false // dismiss keyboard
                            }
                        }
                    }
                
                Text("m") // Example unit
                    .font(.title2.weight(.semibold))
                    .padding(.leading, 8)
            }
            .padding()
        }
        .padding()
        .onTapGesture {
            isEditing = true // Tap anywhere in the field to trigger the pad
        }
    }
}

#Preview{
    popupNumberPad()
}
