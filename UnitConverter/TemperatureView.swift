//
//  TemperatureView.swift
//  UnitConverter
//
//  Created by Gianluca Beltran Bianchi on 18/07/23.
//

import SwiftUI

struct TemperatureView: View {
    enum TemperatureTypes: String, CaseIterable {
        case Celcius = "Celcius"
        case Fahrenheit = "Fahrenheit"
        case Kelvin = "Kelvin"
    }
    
    @State private var fromInput: Double = 1
    @State private var toInput: Double = 33.8
    @State private var fromType = TemperatureTypes.Celcius
    @State private var toType = TemperatureTypes.Fahrenheit
    @State private var prevFromType = TemperatureTypes.Celcius
    @State private var prevToType = TemperatureTypes.Fahrenheit
    
    func convertUnits(from: TemperatureTypes, to: TemperatureTypes, a: Double) -> Double  {
        switch from {
        case .Celcius:
            switch to {
            case .Fahrenheit:
                return (a * 9/5) + 32
            case .Celcius:
                return a
            case .Kelvin:
                return a + 273.15
            }
        case .Fahrenheit:
            switch to {
            case .Fahrenheit:
                return a
            case .Celcius:
                return (a - 32) * 5/9
            case .Kelvin:
                return (a - 32) * 5/9 + 273.15
            }
        case .Kelvin:
            switch to {
            case .Fahrenheit:
                return (a - 273.15) * 9/5 + 32
            case .Celcius:
                return a - 273.15
            case .Kelvin:
                return a
            }
        }
    }
    var body: some View {
        Section {
            HStack {
                TextField("Temperature value", value: $fromInput, formatter: .numberFormat)
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
            Picker("Temperature Units", selection: $fromType) {
                ForEach(TemperatureTypes.allCases, id: \.self) {
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
                TextField("Temperature value", value: $toInput, formatter: .numberFormat)
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
            Picker("Temperature Units", selection: $toType) {
                ForEach(TemperatureTypes.allCases, id: \.self) {
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

struct TemperatureView_Previews: PreviewProvider {
    static var previews: some View {
        TemperatureView()
    }
}
