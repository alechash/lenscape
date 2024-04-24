//
//  DepthOfFieldCalculatorView.swift
//  Lenscape
//
//  Created by Jude Wilson on 4/9/24.
//

import SwiftUI

struct DepthOfFieldCalculatorView: View {
    @AppStorage("selectedSensorSize") var selectedSensorSize: SensorSize = .fullFrame
    @SceneStorage("focalLength") private var focalLength: Double = 50
    @SceneStorage("aperture") private var aperture: Double = 2.8
    @SceneStorage("subjectDistance") private var subjectDistance: Double = 10
    
    private var depthOfField: String {
        let f = focalLength // Focal length in millimeters
        let N = aperture // Aperture (f-stop)
        let c = selectedSensorSize.circleOfConfusion // Circle of confusion in millimeters
        let d = subjectDistance * 1000 // Convert distance to subject from meters to millimeters
        
        // Calculate hyperfocal distance in millimeters
        let H = (f * f) / (N * c) + f
        
        // Calculate near focus limit in millimeters
        let Dn = (d * (H - f)) / (H + d - 2 * f)
        
        // Calculate far focus limit in millimeters
        let Df = H > d ? (d * (H - f)) / (H - d) : Double.infinity
        
        // Calculate depth of field in millimeters and convert to meters for display
        let DoF = (Df - Dn) / 1000 // Convert DoF from millimeters to meters
        
        // Format the output
        if DoF.isInfinite {
            return "Infinite"
        } else {
            return String(format: "%2.2f", DoF)
        }
    }
    
    
    var body: some View {
        Form {
            Section {
                NavigationLink(destination: Settings()) {
                    HStack {
                        Text("Sensor Size")
                            .foregroundStyle(.secondary)
                        Spacer()
                        Text(selectedSensorSize.rawValue).tag(selectedSensorSize)
                            .bold()
                    }
                    .padding(.vertical, 6)
                }
                SliderSettingView(value: $focalLength, label: "Focal Length", range: 1...400, step: 1, postfix: " mm")
                SliderSettingView(value: $aperture, label: "Aperture", range: 1.4...22, step: 0.1, prefix: "f/")
                SliderSettingView(value: $subjectDistance, label: "Sibject Distance", range: 0.1...100, step: 0.1, postfix: " m")
            } header: {
                Text("Adjustments")
                    .headerStyle()
            }
            
            Section(header: Text("Depth of Field").headerStyle()) {
                HStack {
                    Text(depthOfField)
                        .font(.system(size: 60))
                        .monospaced()
                        .fontWeight(.bold)
                    VStack {
                        Text("meters")
                            .font(.system(size:30))
                            .monospaced()
                            .padding(.top, 20)
                            .padding(.leading, 10)
                    }
                    Spacer()
                }
            }
        }
        .navigationBarTitle("DoF Calculator", displayMode: .automatic)
    }
}
