//
//  ContentView.swift
//  UnitConverter
//
//  Created by Gianluca Beltran Bianchi on 15/07/23.
//

import SwiftUI

struct ContentView: View {
    @FocusState public var inputIsFocused: Bool
    
    enum ConversionTypes: String, CaseIterable {
        case Length = "Length"
        case Temperature = "Temp"
        case Mass = "Mass"
        case Time = "Time"
    }
    @State private var conversionType = ConversionTypes.Length

    var body: some View {
        NavigationView {
            ZStack {
                RadialGradient(stops: [
                    .init(color: Color("Color 3"), location: 0.3),
                    .init(color: Color("Color 4"), location: 0.3),
                ], center: .top, startRadius: 200, endRadius: 500)
                .ignoresSafeArea()
                
                Form {
                    Section {
                        Picker("Conversion Type", selection: $conversionType) {
                            ForEach(ConversionTypes.allCases, id: \.self) {
                                Text($0.rawValue)
                            }
                        }
                        .pickerStyle(.segmented)
                    } header: {
                        Text("Unit Type")
                    }
                    switch conversionType {
                    case .Length:
                        LengthView()
                            .focused($inputIsFocused)
                    case .Temperature:
                        TemperatureView()
                            .focused($inputIsFocused)
                    case .Time:
                        TimeView()
                            .focused($inputIsFocused)
                    case .Mass:
                        MassConverter()
                            .focused($inputIsFocused)
                    }
                    
                }
                .scrollContentBackground(.hidden)
                .navigationTitle("Unit Converter")
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        
                        Button("Done") {
                            inputIsFocused = false
                        }
                    }
                }
            }
        }
    }
}

extension Formatter {
    static let numberFormat: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumSignificantDigits = 10
        return formatter
    }()
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
