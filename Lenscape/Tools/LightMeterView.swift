//
//  LightMeterView.swift
//  Lenscape
//
//  Created by Jude Wilson on 4/9/24.
//

import SwiftUI
import AVFoundation

struct LightMeterView: View {
    @StateObject private var lightMeterViewModel = LightMeterViewModel()
    
    @AppStorage("lightDragAmountX") var dragAmountX: Double = 200
    @AppStorage("lightDragAmountY") var dragAmountY: Double = 60
    
    @State var liveX: Double = 200
    @State var liveY: Double = 60
    
    var body: some View {
        
        GeometryReader { gp in
            ZStack {
                CameraPreview(session: lightMeterViewModel.captureSession)
                    .edgesIgnoringSafeArea(.all) // Make the camera preview fill the entire screen
                
                VStack {
                    HStack {
                        Spacer()
                        
                        VStack {
                            
                            HStack {
                                Text("Your Scene")
                                    .bold()
                                    .font(.title2)
                                Spacer()
                                Image(systemName: "arrow.up.and.down.and.arrow.left.and.right")
                                    .foregroundColor(.secondary)
                            }
                            .padding(.bottom, 5)
                            
                            HStack {
                                Text("Ambient Light")
                                    .monospaced()
                                Spacer()
                                Text("\(lightMeterViewModel.ambientLightDescription)")
                                    .monospaced()
                            }
                            .padding(.bottom, 15)
                            
                            HStack {
                                Text("Recommended Settings")
                                    .bold()
                                    .font(.title2)
                                Spacer()
                            }
                            .padding(.bottom, 5)
                            
                            HStack {
                                Text("Aperture")
                                    .monospaced()
                                Spacer()
                                Text("\(lightMeterViewModel.recommendedAperture)")
                                    .monospaced()
                            }
                            
                            HStack {
                                Text("Shutter Speed")
                                    .monospaced()
                                Spacer()
                                Text("\(lightMeterViewModel.recommendedShutterSpeed)")
                                    .monospaced()
                            }
                            
                            HStack {
                                Text("ISO")
                                    .monospaced()
                                Spacer()
                                Text("\(lightMeterViewModel.recommendedISO)")
                                    .monospaced()
                            }
                        }
                        .multilineTextAlignment(.leading)
                        .padding()
                        .foregroundColor(.primary)
                        .background(.background)
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(.gray, lineWidth: 0.5)
                        )
                        .padding()
                        .frame(maxWidth: 400)
                        
                        Spacer()
                    }
                }
                .animation(.default, value: CGPoint(x: self.liveX, y: self.liveY))
                .position(CGPoint(x: self.dragAmountX, y: self.dragAmountY))
                .highPriorityGesture(
                    DragGesture()
                        .onChanged {
                            self.dragAmountX = $0.location.x
                            self.dragAmountY = $0.location.y
                            self.liveX = $0.location.x
                            self.liveY = $0.location.y
                        })
            }
            .onAppear {
                lightMeterViewModel.startCapturing()
            }
            .onDisappear {
                lightMeterViewModel.stopCapturing()
            }
        }
        .toolbar() {
            ToolbarItem {
                Button(action: {
                    self.liveX = 200
                    self.liveY = 60
                    self.dragAmountX = 200
                    self.dragAmountY = 60
                }) {
                    Text("Reset Draggables")
                        .font(.caption)
                        .padding(10)
                        .foregroundColor(.primary)
                        .background(.background)
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(.gray, lineWidth: 0.5)
                        )
                }
            }
        }
    }
}


struct Separator: View {
    var body: some View {
        VStack {
            Divider()
                .frame(height: 1)
                .background(Color.white)
                .padding(.top, 10)
        }
    }
}
