//
//  TimeView.swift
//  UnitConverter
//
//  Created by Gianluca Beltran Bianchi on 18/07/23.
//

import SwiftUI

struct TimeView: View {
    enum TimeTypes: String, CaseIterable {
        case Second = "Second"
        case Minute = "Minute"
        case Hour = "Hour"
        case Day = "Day"
        case Week = "Week"
        case Month = "Month"
        case Year = "Year"
        case Decade = "Decade"
        case Century = "Century"
    }
    
    @State private var fromInput: Double = 1
    @State private var toInput: Double = 33.8
    @State private var fromType = TimeTypes.Second
    @State private var toType = TimeTypes.Hour
    @State private var prevFromType = TimeTypes.Second
    @State private var prevToType = TimeTypes.Hour
    
    let conversionMap = [TimeTypes.Second.rawValue: 1, TimeTypes.Minute.rawValue: 60, TimeTypes.Hour.rawValue: 3600, TimeTypes.Day.rawValue: 86400, TimeTypes.Week.rawValue: 604800, TimeTypes.Month.rawValue: 2.628e+6, TimeTypes.Year.rawValue: 3.154e+7, TimeTypes.Decade.rawValue: 3.154e+8, TimeTypes.Century.rawValue: 3.154e+9]
    
    func convertUnits(from: TimeTypes, to: TimeTypes, a: Double) -> Double  {
        return a * (conversionMap[from.rawValue] ?? 1) / (conversionMap[to.rawValue] ?? 1)
    }
    var body: some View {
        Section {
            HStack {
                TextField("Time value", value: $fromInput, formatter: .numberFormat)
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
            Picker("Time Units", selection: $fromType) {
                ForEach(TimeTypes.allCases, id: \.self) {
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
                TextField("Time value", value: $toInput, formatter: .numberFormat)
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
            Picker("Time Units", selection: $toType) {
                ForEach(TimeTypes.allCases, id: \.self) {
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

struct TimeView_Previews: PreviewProvider {
    static var previews: some View {
        TimeView()
    }
}
