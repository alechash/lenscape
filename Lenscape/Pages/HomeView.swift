//
//  HomeView.swift
//  Lenscape
//
//  Created by Jude Wilson on 4/15/24.
//

import SwiftUI

struct HomeView: View {
    @State private var columnVisibility = NavigationSplitViewVisibility.all
    
    var body: some View {
        NavigationSplitView(columnVisibility: $columnVisibility) {
            List {
                Section {
                    NavigationLink(destination: DepthOfFieldCalculatorView()) {
                        HStack {
                            Image(systemName: "camera.metering.spot")
                            Text("Depth of Field Calculator")
                        }
                    }
                } header: {
                    Text("Calculators")
                        .headerStyle()
                }
                
                Section {
                    NavigationLink(destination: LightMeterView()) {
                        HStack {
                            Image(systemName: "rays")
                            VStack {
                                HStack {
                                    Text("Scene Light Meter")
                                    Spacer()
                                }
                                HStack {
                                    Text("AKA exposure calculator. We'll use your camera to suggest camera settings.")
                                        .font(.caption2)
                                        .foregroundStyle(.secondary)
                                    Spacer()
                                }
                            }
                            .multilineTextAlignment(.leading)
                        }
                    }
                    NavigationLink(destination: GoldenHourView()) {
                        HStack {
                            Image(systemName: "sun.haze")
                            Text("Golden and Blue Hours")
                        }
                    }
                    NavigationLink(destination: ExposureTriangleSimulatorView()) {
                        HStack {
                            Image(systemName: "triangle.inset.filled")
                            Text("Exposure Triangle Simulator")
                        }
                    }
                } header: {
                    Text("Tools")
                        .headerStyle()
                }
                
                Section {
                    NavigationLink(destination: Settings()) {
                        HStack {
                            Image(systemName: "gearshape")
                            Text("Settings")
                        }
                    }
                    NavigationLink(destination: About()) {
                        HStack {
                            Image(systemName: "note.text")
                            Text("About")
                        }
                    }
                    NavigationLink(destination: Settings()) {
                        HStack {
                            Image(systemName: "questionmark.app")
                            Text("Help")
                        }
                    }
                }
            }
            .background(.primary)
            .toolbar(removing: .sidebarToggle)
            .toolbar {
                ToolbarItem {
                    NavigationLink(destination: Settings()) {
                        Image(systemName: "gearshape")
                    }
                }
            }
            .navigationTitle("Lenscape")
        } detail: {
            HomeDetail()
        }
        .navigationSplitViewStyle(.balanced)
    }
}
