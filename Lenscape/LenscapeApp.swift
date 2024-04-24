//
//  LenscapeApp.swift
//  Lenscape
//
//  Created by Jude Wilson on 4/8/24.
//

import SwiftUI
import SwiftData

@main
struct LenscapeApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    var body: some Scene {
        WindowGroup {
            TabView {
                HomeView()
                    .tabItem {
                        Label("Lenscape", systemImage: "camera.aperture")
                    }
                
                LearnView()
                    .tabItem {
                        Label("Lenschool", systemImage: "graduationcap")
                    }
            }
        }
        .modelContainer(sharedModelContainer)
    }
}

extension Text {
    func headerStyle() -> some View {
        self
            .textCase(.none)
            .font(.headline)
            .bold()
    }
}
