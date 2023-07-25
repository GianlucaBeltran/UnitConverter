//
//  LengthView.swift
//  UnitConverter
//
//  Created by Gianluca Beltran Bianchi on 18/07/23.
//

import SwiftUI

struct LengthView: View {
    enum LengthTypes: String, CaseIterable {
        case Kilometer = "Kilometer"
        case Meter = "Meter"
        case Centimeter = "Centimeter"
        case Milimiter = "Milimeter"
        case Mile = "Mile"
        case Yard = "Yard"
        case Foot = "Foot"
        case Inch = "Inch"
        case NauticalMile = "Nautical Mile"
    }
    @State private var fromInputLength: Double = 1
    @State private var toInputLength: Double = 0.000621371
    @State private var fromLenghtType = LengthTypes.Meter
    @State private var toLengthType = LengthTypes.Mile
    @State private var prevFromLengthType = LengthTypes.Meter
    @State private var prevToLenghtType = LengthTypes.Mile
    
    let lengthConversionMap = [LengthTypes.Kilometer.rawValue: 1000, LengthTypes.Meter.rawValue: 1, LengthTypes.Centimeter.rawValue: 0.01, LengthTypes.Milimiter.rawValue: 0.001, LengthTypes.Mile.rawValue: 1609.34, LengthTypes.Yard.rawValue: 0.9144, LengthTypes.Foot.rawValue: 0.3048, LengthTypes.Inch.rawValue: 0.0254, LengthTypes.NauticalMile.rawValue: 1852]
    
    func convertUnits(from: LengthTypes, to: LengthTypes, a: Double) -> Double  {
        return a * (lengthConversionMap[from.rawValue] ?? 1) / (lengthConversionMap[to.rawValue] ?? 1)
    }
    
    var body: some View {
        Section {
            HStack {
                TextField("Length value", value: $fromInputLength, formatter: .numberFormat)
                    .keyboardType(.decimalPad)
                    .frame(height: 70)
                    .multilineTextAlignment(.center)
                    .font(.system(size: 40))
                    .onChange(of: fromInputLength) {newValue in
                        toInputLength = convertUnits(from: fromLenghtType, to: toLengthType, a: fromInputLength)
                    }
                
                Spacer()
                
                Button(action: {
                    UIPasteboard.general.string = String(toInputLength)
                }) {
                    Image(systemName: "doc.on.doc")
                }
            }
            Picker("Length Units", selection: $fromLenghtType) {
                ForEach(LengthTypes.allCases, id: \.self) {
                    Text($0.rawValue)
                }
            }
            .onChange(of: fromLenghtType) {newValue in
                if newValue == toLengthType {
                    fromLenghtType = toLengthType
                    toLengthType = prevFromLengthType
                } else {
                    prevFromLengthType = fromLenghtType
                    prevToLenghtType = toLengthType
                }
                toInputLength = convertUnits(from: fromLenghtType, to: toLengthType, a: fromInputLength)
                
            }
        } header: {
            Text("From")
        }
        Section {
            HStack {
                TextField("Length value", value: $toInputLength, formatter: .numberFormat)
                    .keyboardType(.decimalPad)
                    .frame(height: 70)
                    .multilineTextAlignment(.center)
                    .font(.system(size: 40))
                    .onChange(of: toInputLength) {newValue in
                        fromInputLength = convertUnits(from: toLengthType, to: fromLenghtType, a: toInputLength)
                    }
                Spacer()
                
                Button(action: {
                    UIPasteboard.general.string = String(toInputLength)
                    
                }) {
                    Image(systemName: "doc.on.doc")
                }
            }
            Picker("Length Units", selection: $toLengthType) {
                ForEach(LengthTypes.allCases, id: \.self) {
                    Text($0.rawValue)
                }
            }
            .onChange(of: toLengthType) {newValue in
                if newValue == fromLenghtType {
                    toLengthType = fromLenghtType
                    fromLenghtType = prevToLenghtType
                } else {
                    prevFromLengthType = fromLenghtType
                    prevToLenghtType = toLengthType
                }
                toInputLength = convertUnits(from: fromLenghtType, to: toLengthType, a: fromInputLength)
            }
        } header: {
            Text("To")
        }
    }
}

struct LengthView_Previews: PreviewProvider {
    static var previews: some View {
        LengthView()
    }
}
