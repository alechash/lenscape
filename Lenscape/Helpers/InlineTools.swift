//
//  InlineTools.swift
//  Lenscape
//
//  Created by Jude Wilson on 4/22/24.
//

import SwiftUI

struct InlineTools: View {
    @Environment(\.colorScheme) var colorScheme
    @State var value: String
    
    var body: some View {
        if (value == "dof_calc") {
            NavigationLink(destination: DepthOfFieldCalculatorView()) {
                HStack {
                    Text("Explore Depth of Field Calculator")
                    //.foregroundStyle(colorScheme == .dark ? .white : .black)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundStyle(.gray)
                }
                .padding(.all, 15)
                .background(colorScheme == .dark ? Color(red: 27/255, green: 27/255, blue: 30/255) : Color(red:242/255, green: 242/255, blue: 247/255) )
                .clipShape(
                    RoundedRectangle(cornerRadius: 10)
                )
                .padding(.horizontal, 15)
                .padding(.vertical, 5)
            }
        } else if (value == "exp_tri") {
            NavigationLink(destination: ExposureTriangleSimulatorView()) {
                HStack {
                    Text("Try the Exposure Triangle Simulator")
                    //.foregroundStyle(colorScheme == .dark ? .white : .black)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundStyle(.gray)
                }
                .padding(.all, 15)
                .background(colorScheme == .dark ? Color(red: 27/255, green: 27/255, blue: 30/255) : Color(red:242/255, green: 242/255, blue: 247/255) )
                .clipShape(
                    RoundedRectangle(cornerRadius: 10)
                )
                .padding(.horizontal, 15)
                .padding(.vertical, 5)
            }
        }
    }
}
