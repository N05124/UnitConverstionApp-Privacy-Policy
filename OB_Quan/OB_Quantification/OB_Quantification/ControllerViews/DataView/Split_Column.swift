//
//  NumberPad.swift
//  OB_Quantification
//
//  Created by Arison on 11/7/25.
//


import SwiftUI
import Foundation

struct SplitColumn: View {
    let tab: TabItem
    @ObservedObject var navBarModel: NavBarModel
    var onActivate: ((TabItem) -> Void)? = nil
    
//    @FocusState private var isEditing: Bool  // Track focus for the keyboard
    @State private var inputValue: String = ""
    @FocusState private var isEditing: Bool
    @State private var selectedUnit: String? = ""
//    @State private var inputValue = ""
//    @State private var selectedUnit: String? = nil
    @State private var isScientificExpanded: Bool = false
    @State private var isNauticalExpanded: Bool = false
    @State private var isMetricExpanded: Bool = false
    @State private var isImperialExpanded: Bool = false

    var body: some View {
        VStack {
            HStack(alignment: .top) {
                
                // LEFT COLUMN
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        
                        Text("Inital Unit:")
                            .font(.headline)
                            .padding(.top, 30)
                        CollapsibleSection(title: "Imperial", units: tab.category.imperial, selectedUnit: $selectedUnit)
                        CollapsibleSection(title: "Metric", units: tab.category.metric, selectedUnit: $selectedUnit)
                        CollapsibleSection(title: "Scientific", units: tab.category.scientific, selectedUnit: $selectedUnit)
                        CollapsibleSection(title: "Nautical", units: tab.category.nautical, selectedUnit: $selectedUnit)
                    }
                    .padding(.horizontal)
                }
                .frame(maxWidth: 175)

                Divider()

                // RIGHT COLUMN
                ScrollView {
                    VStack(alignment: .leading, spacing: 10) {
                        
                        if let value = Double(inputValue), let fromUnit = selectedUnit {
                            Text("Conversions from \(fromUnit):")
                                .font(.headline)
                                .padding(.bottom, 4)

                            let conversions = tab.category.convertedValues(value: value, from: fromUnit)
                            
                            // MARK: Imperial
                            if let imperialDict = conversions["Imperial"] {
                                DisclosureGroup(isExpanded: $isImperialExpanded) {
                                    let list = imperialDict.sorted { $0.value > $1.value }
                                    VStack(alignment: .leading, spacing: 6) {
                                        ForEach(list, id: \.key) { pair in
                                                        if abs(pair.value) < 1e17 {
                                                            // Safe NavigationLink
                                                            NavigationLink(
                                                                destination: CalculatedPrecision(
                                                                    number: pair.value.trimmedDecimalString,
                                                                    unit: pair.key
                                                                )
                                                            ) {
                                                                VStack(alignment: .leading) {
                                                                    Text(pair.key)
                                                                    Text(pair.value.formattedSmart)
                                                                }
                                                                .padding(.leading, 4)
                                                            }
                                                            .buttonStyle(.plain)
                                                        } else {
                                                            // Fallback for too large values
                                                            VStack(alignment: .leading, spacing: 2) {
                                                                Text(pair.key)
                                                                Text(pair.value.formattedSmart)
                                                                    .foregroundColor(.gray)
                                                                Text("Too large to preview")
                                                                    .font(.caption)
                                                                    .foregroundColor(.red)
                                                            }
                                                            .padding(.leading, 4)
                                                        }
                                                        Divider()
                                                    }
                                                }
                                                .padding(.top, 4)
                                            } label: {
                                    Text("Imperial")
                                        .font(.headline)
                                        .padding(.top, 8)
                                }
                            }

                            // MARK: Metric
                            if let metricDict = conversions["Metric"] {
                                DisclosureGroup(isExpanded: $isMetricExpanded) {
                                    let list = metricDict.sorted { $0.value > $1.value }
                                    VStack(alignment: .leading, spacing: 6) {
                                        ForEach(list, id: \.key) { pair in
                                                        if abs(pair.value) < 1e17 {
                                                            // Safe NavigationLink
                                                            NavigationLink(
                                                                destination: CalculatedPrecision(
                                                                    number: pair.value.trimmedDecimalString,
                                                                    unit: pair.key
                                                                )
                                                            ) {
                                                                VStack(alignment: .leading) {
                                                                    Text(pair.key)
                                                                    Text(pair.value.formattedSmart)
                                                                }
                                                                .padding(.leading, 4)
                                                            }
                                                            .buttonStyle(.plain)
                                                        } else {
                                                            // Fallback for too large values
                                                            VStack(alignment: .leading, spacing: 2) {
                                                                Text(pair.key)
                                                                Text(pair.value.formattedSmart)
                                                                    .foregroundColor(.gray)
                                                                Text("Too large to preview")
                                                                    .font(.caption)
                                                                    .foregroundColor(.red)
                                                            }
                                                            .padding(.leading, 4)
                                                        }
                                                        Divider()
                                                    }
                                                }
                                                .padding(.top, 4)
                                            } label: {
                                    Text("Metric")
                                        .font(.headline)
                                        .padding(.top, 8)
                                }
                            }

                            // MARK: Scientific
                            if let scientificDict = conversions["Scientific"] {
                                DisclosureGroup(isExpanded: $isScientificExpanded) {
                                    let list = scientificDict.sorted { $0.value > $1.value }
                                    VStack(alignment: .leading, spacing: 6) {
                                        ForEach(list, id: \.key) { pair in
                                                        if abs(pair.value) < 1e17 {
                                                            // Safe NavigationLink
                                                            NavigationLink(
                                                                destination: CalculatedPrecision(
                                                                    number: pair.value.trimmedDecimalString,
                                                                    unit: pair.key
                                                                )
                                                            ) {
                                                                VStack(alignment: .leading) {
                                                                    Text(pair.key)
                                                                    Text(pair.value.formattedSmart)
                                                                }
                                                                .padding(.leading, 4)
                                                            }
                                                            .buttonStyle(.plain)
                                                        } else {
                                                            // Fallback for too large values
                                                            VStack(alignment: .leading, spacing: 2) {
                                                                Text(pair.key)
                                                                Text(pair.value.formattedSmart)
                                                                    .foregroundColor(.gray)
                                                                Text("Too large to preview")
                                                                    .font(.caption)
                                                                    .foregroundColor(.red)
                                                            }
                                                            .padding(.leading, 4)
                                                        }
                                                        Divider()
                                                    }
                                                }
                                                .padding(.top, 4)
                                            }label: {
                                    Text("Scientific")
                                        .font(.headline)
                                        .padding(.top, 8)
                                }
                            }

                            // MARK: Nautical
                            if let nauticalDict = conversions["Nautical"] {
                                DisclosureGroup(isExpanded: $isNauticalExpanded) {
                                    let list = nauticalDict.sorted { $0.value > $1.value }
                                    VStack(alignment: .leading, spacing: 6) {
                                        ForEach(list, id: \.key) { pair in
                                            NavigationLink(destination: CalculatedPrecision(number: pair.value.trimmedDecimalString, unit: pair.key)) {
                                                VStack(alignment: .leading) {
                                                    Text(pair.key)
                                                    Text(pair.value.formattedSmart)
                                                }
                                                
                                                .padding(.leading, 4)
                                            }
                                            .buttonStyle(.plain)
                                            Divider()
                                        }
                                    }
                                    .padding(.top, 4)
                                } label: {
                                    Text("Nautical")
                                        .font(.headline)
                                        .padding(.top, 8)
                                }
                            }

                        } else {
                            Text("Select a unit and enter a number to convert.")
                                .foregroundColor(.gray)
                        }
                    }
                    .padding()
                }

            }
            .frame(maxHeight: .infinity)
            
                HStack {
                    TextField("Enter Value", text: $inputValue)
                        .font(.title2.weight(.semibold))
                        .keyboardType(.decimalPad)
                        .focused($isEditing)
                        .onChange(of: inputValue) {
                            let filtered = inputValue.filter { $0.isNumber || $0 == "." }

                            let components = filtered.split(separator: ".")
                            if components.count > 1 {
                                inputValue = components[0] + "." + components[1...].joined()
                            } else {
                                inputValue = filtered
                            }
                        }
                    
                    if let unit = selectedUnit {
                        Text(unit)
                            .font(.title2.weight(.semibold))
                    }
                }
                .padding(.leading, 40)
                .padding(.top, 30)
                .padding(.bottom, 50)
                .padding(.trailing, 50)
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        isEditing = false
                    }
                }
            }
                
        }
    }
}


#Preview {
    PreviewContainer()
}

struct PreviewContainer: View {
    @StateObject var navBarModel = NavBarModel()

    var body: some View {
        SplitColumn(
            tab: TabItem(id: UUID(), title: "Length", systemImage: "ruler", currentPage: "Length", status: "Active", isExportable: true, category: Length(name: "Meters")),
            navBarModel: navBarModel
        )
    }
}

