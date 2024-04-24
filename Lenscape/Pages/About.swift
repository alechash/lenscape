//
//  About.swift
//  Lenscape
//
//  Created by Jude Wilson on 4/9/24.
//

import SwiftUI
import ConfettiSwiftUI

struct About: View {
    @State private var counter: Int = 0
    
    var body: some View {
        ZStack {
            ScrollView {
                HStack {
                    Spacer()
                }

                HStack {
                    Image(uiImage: UIImage(named: "AppIcon") ?? UIImage())
                        .resizable()
                        .scaledToFit()
                        .frame(width: 35, height: 35)
                        .cornerRadius(8)
                    Text("Lenscape")
                        .font(.title)
                        .bold()
                    Spacer()
                }

                HStack {
                    Text("Lenscape is designed to help make your photography experience more fun. We want to help you learn more about the skill of shooting and framing as well as help you when you're in a tough spot.\n\nUse our \"Shots\" tab to find the best and most unique shots. Use the \"Tools\" tab to access our calculators and tools to help you out. Use the \"Learn\" tab to developer new skills!\n\nWe are a one person team based in Dayton, Ohio!\n\nThanks for trying the app!")
                        .padding(.horizontal)
                    Spacer()
                }
                .padding(.vertical, 15)

                Button(action: {
                    withAnimation {
                        counter += 1
                    }
                }) {
                    HStack {
                        Spacer()
                        Text("Thanks for the app!")
                        Spacer()
                    }
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .clipShape(Capsule())
                .padding(.top, 20)

                Link("Visit our Website", destination: URL(string: "https://www.example.com")!)
                Link("Privacy Policy", destination: URL(string: "https://www.example.com/privacy")!)
                Link("Terms & Conditions", destination: URL(string: "https://www.example.com/terms")!)

                Spacer()
            }
            .padding(.horizontal, 30)
            .onAppear {
                counter += 1
            }
        }
        .confettiCannon(counter: $counter, num: 50 , colors: [.red, .primary, .blue], confettiSize: 20)
        .navigationTitle("About Us")
    }
}
