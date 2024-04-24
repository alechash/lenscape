//
//  Settings.swift
//  Lenscape
//
//  Created by Jude Wilson on 4/9/24.
//

import SwiftUI

struct Settings: View {
    @AppStorage("selectedSensorSize") var selectedSensorSize: SensorSize = .fullFrame
    
    var body: some View {
        Form {
            Section(header: Text("Default Sensor").headerStyle()) {
                Picker("Sensor Size", selection: $selectedSensorSize) {
                    ForEach(SensorSize.allCases) { size in
                        Text(size.rawValue).tag(size)
                    }
                }
                .pickerStyle(.wheel)
            }
        }
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.large)
    }
}
