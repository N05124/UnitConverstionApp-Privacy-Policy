//
//  Calculated_Precision.swift
//  OB_Quantification
//
//  Created by Arison on 11/5/25.
/**
Calculated precision -
Navigation bar on top
 
 if sent by input number use input text, if blank open with default text
 'enter value for conversion'
Text area with calculated conversion
Contain points of precision to the X decimal
Where X is greatest precision value
A conventional desktop computer can contain
In a programming language
(I.e. a double value in Java can contain like 256? points of precision or something) * look up for exact spec
 
Input area - increase or decrease points of precision
 
Pile style - plus or minus increase decrease points of precision round points
 
On tapping the window or text area number will be copied to clipboard
The screen will display toast 'copied!'
 
 ||==========Navigation Header====[export]| - stage in pdf or share results
 ||---------------------Divider()-----------------------|
 #Calculated Precision
 ||-- units of measurement [state]----------------|
 ||--[number input] --------------------------------| - states [edit, type, view]
 ||-- [decimal][scientific][other{}]--------------|
 ||-- [numperpad] ---------------------------------|
 
 #edit enable cursor no numpad
 #type activate numpad reduce number window percent
 #view on tap copy number - no direct interaction
"""
*/
import Foundation
import SwiftUI

struct CalculatedPrecision: View {
    @State private var numberText: String
    let unit: String
    @FocusState var isEditing: Bool  // tracks focus

    @State private var accumulator: Double? = nil
    @State private var pendingOperator: String? = nil
    @State private var enteringNewNumber: Bool = true

    init(number: String, unit: String) {
        self._numberText = State(initialValue: number)
        self.unit = unit
    }

    var number: Double { Double(numberText) ?? 0 }
        
    var body: some View {
        VStack {
            Text("Precision Reivew")
                .padding(.top, 10)
                .padding(.leading, 10)
                .frame(maxWidth: .infinity, alignment: .center)
            Text("Integer digit count: \(totalDigitCount(from: numberText))")
                .padding(.top, 10)
                .padding(.leading, 10)
                .frame(maxWidth: .infinity, alignment: .leading)
            Divider()
            Text("Scale of precision: \(fractionalDigitCount(from: numberText))")
                .padding(.top, 10)
                .padding(.leading, 10)
                .frame(maxWidth: .infinity, alignment: .leading)
            Divider()
            Text("Selected Unit of Measurement: \(unit)")
                .padding(.leading, 10)
                .frame(maxWidth: .infinity, alignment: .leading)
            Divider()
            Text("Rounded Whole Value: \(Int(abs(number).rounded()))")
                .padding(.leading, 10)
                .frame(maxWidth: .infinity, alignment: .leading)
            Divider()
            Spacer()
//            Button(action: {
//                isEditing.toggle()
//            }) {
//                Text(isEditing ? "Done" : "Edit")
//                    .font(.headline)
//                    .padding(.vertical, 6)
//                    .padding(.horizontal, 12)
//                    .background(Color(.systemGray5))
//                    .cornerRadius(8)
//            }
//            .frame(maxWidth: .infinity, alignment: .trailing)
//            .padding()

            // --- Text Area ---
            TextEditor(text: $numberText)
                .font(.system(size: 24))
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .focused($isEditing) // bind focus
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(isEditing ? Color.accentColor : Color.clear, lineWidth: 2)
                )
                .padding()

//            // --- Calculator-style Number Pad appears only when editing ---
//            if isEditing {
//                VStack(spacing: 8) {
//                    // Calculator-style pad
//                    VStack(spacing: 8) {
//                        HStack(spacing: 8) {
//                            CalcButton("AC")
//                            CalcButton("⌫")
//                            CalcButton("±")
//                            CalcButton("%")
//                        }
//                        HStack(spacing: 8) {
//                            CalcButton("7"); CalcButton("8"); CalcButton("9"); CalcButton("÷")
//                        }
//                        HStack(spacing: 8) {
//                            CalcButton("4"); CalcButton("5"); CalcButton("6"); CalcButton("×")
//                        }
//                        HStack(spacing: 8) {
//                            CalcButton("1"); CalcButton("2"); CalcButton("3"); CalcButton("−")
//                        }
//                        HStack(spacing: 8) {
//                            CalcButton("0")
//                                .frame(maxWidth: .infinity)
//                            CalcButton(".")
//                            CalcButton("+")
//                        }
//                        HStack(spacing: 8) {
//                            CalcButton("=")
//                        }
//                    }
//                    .padding(.horizontal)
//                }
//                .padding(.bottom, 16)
//                .background(Color(.systemBackground).shadow(radius: 2))
//                .transition(.move(edge: .bottom))
//                .animation(.easeInOut, value: isEditing)
//            }
        }
//        .ignoresSafeArea(.keyboard) // prevents double padding with system keyboard
    }

//    @ViewBuilder
//    private func CalcButton(_ title: String) -> some View {
//        Button(action: { handleKeyPress(title) }) {
//            Text(title)
//                .font(.title2)
//                .frame(maxWidth: .infinity, maxHeight: 50)
//                .background(Color(.systemGray5))
//                .cornerRadius(8)
//        }
//    }
    
    func fractionalDigitCount(from text: String) -> Int {
        // Normalize localized decimal separator if needed (assumes '.')
        // Count digits after the first '.' only; ignore additional '.' if present
        guard let dotIndex = text.firstIndex(of: ".") else { return 0 }
        let fractional = text[text.index(after: dotIndex)...]
        // Only count numeric digits, ignore any trailing non-digits
        return fractional.filter { $0.isNumber }.count
    }
    
    func totalDigitCount(from text: String) -> Int {
        // Count only numeric digits, ignore sign and decimal separator
        return text.filter { $0.isNumber }.count
    }
    
    private func formatNumber(_ value: Double) -> String {
        if value.isNaN || value.isInfinite { return "0" }
        else{
            let round = value + 1e-10
            return String(Int(round.rounded()))
        }
//        return String(value)
    }

    func numberCount(numberString: String) -> Int {
        let digitCount: Int
        if numberString.contains(".") {
            // remove decimal and count remaining characters
            digitCount = numberString.filter { $0 != "." }.count
        } else {
            digitCount = numberString.count
        }

        print("Digit count:", digitCount) // 7
        return digitCount
    }
//
//    // MARK: - Handle Key Press
//    func handleKeyPress(_ key: String) {
//        func commitPendingOperation(with operand: Double) {
//            guard let op = pendingOperator else { accumulator = operand; return }
//            let lhs = accumulator ?? 0
//            switch op {
//            case "+": accumulator = lhs + operand
//            case "−": accumulator = lhs - operand
//            case "×": accumulator = lhs * operand
//            case "÷": accumulator = operand == 0 ? 0 : lhs / operand
//            default: break
//            }
//        }
//
//        switch key {
//        case "AC":
//            numberText = "0"
//            accumulator = nil
//            pendingOperator = nil
//            enteringNewNumber = true
//
//        case "⌫":
//            if enteringNewNumber { // operate on current display
//                if numberText.count > 1 {
//                    numberText.removeLast()
//                    if numberText == "-" { numberText = "0" }
//                } else {
//                    numberText = "0"
//                }
//            }
//
//        case "±":
//            if numberText.hasPrefix("-") {
//                numberText.removeFirst()
//            } else if numberText != "0" {
//                numberText = "-" + numberText
//            }
//
//        case "%":
//            if let val = Double(numberText) {
//                numberText = String(val / 100)
//                enteringNewNumber = true
//            }
//
//        case ".":
//            if enteringNewNumber {
//                numberText = "0."
//                enteringNewNumber = false
//            } else if !numberText.contains(".") {
//                numberText.append(".")
//            }
//
//        case "+", "−", "×", "÷":
//            // finalize current entry
//            let current = Double(numberText) ?? 0
//            if accumulator == nil || pendingOperator == nil || enteringNewNumber {
//                // First operator or replacing operator
//                if accumulator == nil { accumulator = current }
//            } else {
//                // chain operation
//                commitPendingOperation(with: current)
//            }
//            pendingOperator = key
//            if let acc = accumulator { numberText = formatNumber(acc) }
//            enteringNewNumber = true
//
//        case "=":
//            let current = Double(numberText) ?? 0
//            if accumulator == nil { accumulator = current }
//            commitPendingOperation(with: current)
//            pendingOperator = nil
//            if let acc = accumulator { numberText = formatNumber(acc) }
//            enteringNewNumber = true
//
//        default: // digits 0-9
//            if key.allSatisfy({ $0.isNumber }) {
//                if enteringNewNumber || numberText == "0" {
//                    numberText = key
//                    enteringNewNumber = false
//                } else {
//                    numberText.append(contentsOf: key)
//                }
//            }
//        }
//    }
}

#Preview {
    CalculatedPrecision(number: "0.0", unit: "Meter")
}
