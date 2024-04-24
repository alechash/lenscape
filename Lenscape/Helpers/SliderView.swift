//
//  SliderView.swift
//  Lenscape
//
//  Created by Jude Wilson on 4/9/24.
//

import SwiftUI

struct SliderSettingView: View {
    @Binding var value: Double
    var label: String
    var range: ClosedRange<Double>
    var step: Double
    var isShutterSpeed: Bool = false
    var isAperture: Bool = false
    var prefix: String?
    var postfix: String?

    var body: some View {
        VStack {
            HStack {
                Text("\(label)")
                    .foregroundColor(.secondary)
                Spacer()
                    /*.padding(.bottom, 1)
                    .border(.secondary)
                    .padding(.horizontal, 3)
                    .padding(.top, 10)*/
                Text("\(isShutterSpeed ? "\(prefix ?? "")\(Int(value))\(postfix ?? "")" : isAperture ? "\(prefix ?? "")\(value, specifier: "%g")\(postfix ?? "")" : "\(prefix ?? "")\(value, specifier: "%g")\(postfix ?? "")")")
                    .foregroundColor(.secondary)
            }
            Slider(value: $value, in: range, step: step)
        }
        .padding(.top, 6)
    }
}
