//
//  SensorSize.swift
//  Lenscape
//
//  Created by Jude Wilson on 4/9/24.
//

enum SensorSize: String, CaseIterable, Identifiable {
    case mediumFormat = "Medium Format"
    case fullFrame = "Full Frame"
    case apsH = "APS-H"
    case apsC = "APS-C"
    case apsCCanon = "APS-C Canon"
    case foveon = "Foveon"
    case fourThirds = "Four Thirds"
    case oneInch = "1 Inch"
    case twoThirdInch = "2/3 Inch"
    case oneOneEightInch = "1/1.8 Inch"
    case oneTwoFiveInch = "1/2.5 Inch"

    var id: String { self.rawValue }
}

extension SensorSize {
    var circleOfConfusion: Double {
        switch self {
        case .mediumFormat:
            return 0.05
        case .fullFrame:
            return 0.03
        case .apsH:
            return 0.025
        case .apsC, .apsCCanon:
            return 0.02
        case .foveon:
            return 0.019
        case .fourThirds:
            return 0.015
        case .oneInch:
            return 0.011
        case .twoThirdInch:
            return 0.008
        case .oneOneEightInch:
            return 0.007
        case .oneTwoFiveInch:
            return 0.005
        }
    }
}
