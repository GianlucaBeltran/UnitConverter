//
//  MassConverter.swift
//  UnitConverter
//
//  Created by Gianluca Beltran Bianchi on 18/07/23.
//

import SwiftUI

struct MassConverter: View {
    enum MassTypes: String, CaseIterable {
        case Tonne = "Tonne"
        case Kilogram = "Kilogram"
        case Gram = "Gram"
        case Miligram = "Miligram"
        case Microgram = "Microgram"
        case ImperialTon = "Imperial Ton"
        case USTon = "US Ton"
        case Stone = "Stone"
        case Pound = "Pound"
        case Ounce = "Ounce"
    }
    
    @State private var fromInput: Double = 1
    @State private var toInput: Double = 2.20462
    @State private var fromType = MassTypes.Kilogram
    @State private var toType = MassTypes.Pound
    @State private var prevFromType = MassTypes.Kilogram
    @State private var prevToType = MassTypes.Pound
    
    let conversionMap = [MassTypes.Tonne.rawValue: 1000, MassTypes.Kilogram.rawValue: 1, MassTypes.Gram.rawValue: 0.001, MassTypes.Miligram.rawValue: 1e-6, MassTypes.Microgram.rawValue: 1e-9, MassTypes.ImperialTon.rawValue: 1016.05, MassTypes.USTon.rawValue: 907.185, MassTypes.Stone.rawValue: 6.35029, MassTypes.Pound.rawValue: 0.453592, MassTypes.Ounce.rawValue: 0.0283495]
    
    func convertUnits(from: MassTypes, to: MassTypes, a: Double) -> Double  {
        return a * (conversionMap[from.rawValue] ?? 1) / (conversionMap[to.rawValue] ?? 1)
    }
    var body: some View {
        Section {
            HStack {
                TextField("Mass value", value: $fromInput, formatter: .numberFormat)
                    .keyboardType(.decimalPad)
                    .frame(height: 70)
                    .multilineTextAlignment(.center)
                    .font(.system(size: 40))
                    .onChange(of: fromInput) {newValue in
                        toInput = convertUnits(from: fromType, to: toType, a: fromInput)
                    }
                
                Spacer()
                
                Button(action: {
                    UIPasteboard.general.string = String(toInput)
                }) {
                    Image(systemName: "doc.on.doc")
                }
            }
            Picker("Mass Units", selection: $fromType) {
                ForEach(MassTypes.allCases, id: \.self) {
                    Text($0.rawValue)
                }
            }
            .onChange(of: fromType) {newValue in
                if newValue == toType {
                    fromType = toType
                    toType = prevFromType
                } else {
                    prevFromType = fromType
                    prevToType = toType
                }
                toInput = convertUnits(from: fromType, to: toType, a: fromInput)
                
            }
        } header: {
            Text("From")
        }
        Section {
            HStack {
                TextField("Mass value", value: $toInput, formatter: .numberFormat)
                    .keyboardType(.decimalPad)
                    .frame(height: 70)
                    .multilineTextAlignment(.center)
                    .font(.system(size: 40))
                    .onChange(of: toInput) {newValue in
                        fromInput = convertUnits(from: toType, to: fromType, a: toInput)
                    }
                Spacer()
                
                Button(action: {
                    UIPasteboard.general.string = String(toInput)
                }) {
                    Image(systemName: "doc.on.doc")
                }
            }
            Picker("Mass Units", selection: $toType) {
                ForEach(MassTypes.allCases, id: \.self) {
                    Text($0.rawValue)
                }
            }
            .onChange(of: toType) {newValue in
                if newValue == fromType {
                    toType = fromType
                    fromType = prevToType
                } else {
                    prevFromType = fromType
                    prevToType = toType
                }
                toInput = convertUnits(from: fromType, to: toType, a: fromInput)
            }
        } header: {
            Text("To")
        }
    }
}

struct MassConverter_Previews: PreviewProvider {
    static var previews: some View {
        MassConverter()
    }
}
