//
//  GoldenHourView.swift
//  Lenscape
//
//  Created by Jude Wilson on 4/9/24.
//

import SwiftUI
import MapKit
import SunKit

struct GoldenHourView: View {
    @StateObject private var locationManager = LocationManager()
    @State var currentLocation:  CLLocationCoordinate2D?
    @State private var theSun: Sun?
    @State private var tz: TimeZone?

    @State private var userLoc: CLLocationCoordinate2D?
    
    let format = DateFormatter()
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 34.0522, longitude: -118.2437),
        span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
    )
    
    @State private var userReg = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 34.0522, longitude: -118.2437),
        span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
    )
    
    @AppStorage("dragAmountX") var dragAmountX: Double = 200
    @AppStorage("dragAmountY") var dragAmountY: Double = 60
    
    @State var liveX: Double = 200
    @State var liveY: Double = 60
    
    let timeFormat = DateFormatter()

    var body: some View {
        VStack {
            if let location = locationManager.location {
                GeometryReader { gp in
                    ZStack {
                        Map(coordinateRegion: $region)
                            .edgesIgnoringSafeArea(.all)
                            .onAppear {
                                format.dateFormat = "MM/dd"
                                
                                timeFormat.timeZone = .init(identifier: tz?.identifier ?? "Americas/New_York")
                                timeFormat.dateFormat = "hh:mm"
                                
                                region.center = location
                                userReg.center = location
                                
                                self.liveX = self.dragAmountX
                                self.liveY = self.dragAmountY
                            }
                            .onChange(of: region.center.latitude) {
                                Task {
                                    let goldenHours = GoldenHourCalculator.calculate(for: region.center)
                                    theSun = goldenHours.theSun
                                    tz = goldenHours.tz
                                    timeFormat.timeZone = .init(identifier: tz?.identifier ?? "Americas/New_York")
                                }
                            }
                        
                        Image(systemName: "scope")
                            .font(.largeTitle)
                            .foregroundColor(.primary)
                        
                        VStack {
                            HStack {
                                Spacer()
                                VStack {
                                    HStack {
                                        Text("Golden Hours for Today")
                                            .bold()
                                            .font(.title2)
                                        Spacer()
                                        Image(systemName: "arrow.up.and.down.and.arrow.left.and.right")
                                            .foregroundColor(.secondary)
                                    }
                                    .padding(.bottom, 5)
                                    
                                    HStack {
                                        Text("Morning Hours")
                                            .bold()
                                        Spacer()
                                    }
                                    
                                    HStack {
                                        VStack {
                                            HStack {
                                                Text("Blue")
                                                    .monospaced()
                                                    .font(.system(size: 14))
                                                    .padding(.top, 1)
                                                Spacer()
                                            }
                                            HStack {
                                                Text("Golden")
                                                    .monospaced()
                                                    .font(.system(size: 14))
                                                    .padding(.top, 1)
                                                Spacer()
                                            }
                                        }
                                        Spacer()
                                        VStack {
                                            Text("\(timeFormat.string(from: theSun?.morningBlueHourStart ?? Date())) \(Image(systemName: "arrow.forward")) \(timeFormat.string(from: theSun?.morningBlueHourEnd ?? Date())) AM")
                                                .monospaced()
                                                .font(.system(size: 14))
                                                .padding(.top, 1)
                                            Text("\(timeFormat.string(from: theSun?.morningGoldenHourStart ?? Date())) \(Image(systemName: "arrow.forward")) \(timeFormat.string(from: theSun?.morningGoldenHourEnd ?? Date())) AM")
                                                .monospaced()
                                                .font(.system(size: 14))
                                                .padding(.top, 1)
                                        }

                                    }
                                    
                                    HStack {
                                        Text("Evening Hours")
                                            .bold()
                                        Spacer()
                                    }
                                    .padding(.top, 5)
                                    
                                    HStack {
                                        VStack {
                                            HStack {
                                                Text("Golden")
                                                    .monospaced()
                                                    .font(.system(size: 14))
                                                    .padding(.top, 1)
                                                Spacer()
                                            }
                                            HStack {
                                                Text("Blue")
                                                    .monospaced()
                                                    .font(.system(size: 14))
                                                    .padding(.top, 1)
                                                Spacer()
                                            }
                                        }
                                        Spacer()
                                        VStack {
                                            Text("\(timeFormat.string(from: theSun?.eveningGoldenHourStart ?? Date())) \(Image(systemName: "arrow.forward")) \(timeFormat.string(from: theSun?.eveningGoldenHourEnd ?? Date())) PM")
                                                .monospaced()
                                                .font(.system(size: 14))
                                                .padding(.top, 1)
                                            Text("\(timeFormat.string(from: theSun?.eveningBlueHourStart ?? Date())) \(Image(systemName: "arrow.forward")) \(timeFormat.string(from: theSun?.eveningBlueHourEnd ?? Date())) PM")
                                                .monospaced()
                                                .font(.system(size: 14))
                                                .padding(.top, 1)
                                        }

                                    }
                                    
                                    /*HStack {
                                        Text("Tomorrow Morning")
                                            .bold()
                                        Spacer()
                                        Text("\(tm1) \(Image(systemName: "arrow.forward")) \(tm2) AM")
                                            .monospaced()
                                    }*/
                                    .onAppear {
                                        let goldenHours = GoldenHourCalculator.calculate(for: region.center)
                                        theSun = goldenHours.theSun
                                        tz = goldenHours.tz
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
                                .padding(.bottom, -15)
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
                    
                }
            } else {
                Text("Determining your location...")
            }
        }
        .toolbar() {
            ToolbarItem {
                Button(action: {
                    withAnimation {
                        self.region = userReg
                    }
                }) {
                    Text("Zoom to Me")
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
