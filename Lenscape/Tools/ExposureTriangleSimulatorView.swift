//
//  ExposureTriangleSimulatorView.swift
//  Lenscape
//
//  Created by Jude Wilson on 4/8/24.
//

import SwiftUI

struct ExposureTriangleSimulatorView: View {
    @SceneStorage("apertureValue") private var apertureValue: Double = 8 // Range: 1.4 to 22
    @SceneStorage("shutterSpeedValue") private var shutterSpeedValue: Double = 60 // Range: 1/4000 to 1 second
    @SceneStorage("isoValue") private var isoValue: Double = 50 // Range: 100 to 6400
    
    var body: some View {
        Form {
            Section {
                SliderSettingView(value: $apertureValue, label: "Aperture", range: 1.4...22, step: 0.1, isAperture: true, prefix: "f/")
                SliderSettingView(value: $shutterSpeedValue, label: "Shutter", range: 1...4000, step: 1, isShutterSpeed: true, prefix: "1/", postfix: "s")
                SliderSettingView(value: $isoValue, label: "ISO", range: 50...6400, step: 50)
            } header: {
                Text("Adjustments")
                    .headerStyle()
            }
                        
            ExposureTriangleVisualization(apertureValue: apertureValue, shutterSpeedValue: shutterSpeedValue, isoValue: isoValue)
                .frame(height: 300)
                .padding(30)
            
        }
        .navigationTitle("Exposure Triangle")
    }
}

struct ExposureTriangleVisualization: View {
    var apertureValue: Double
    var shutterSpeedValue: Double
    var isoValue: Double
    
    private func calculateStrokeWidths() -> (aperture: CGFloat, shutterSpeed: CGFloat, iso: CGFloat) {
        // Simplify and normalize the calculation here for demonstration purposes
        let apertureWidth = ((6 - 1) * ((1*(22-apertureValue)) / 22)) + 1
        let shutterSpeedWidth = ((6 - 1) * ((1*(shutterSpeedValue)) / 4000)) + 1 // Increase stroke width for slower speeds
        let isoWidth = ((6 - 1) * ((1*(6400-isoValue)) / 6400)) + 1 // Increase stroke width as ISO goes up
        
        return (apertureWidth, shutterSpeedWidth, isoWidth)
    }
    
    var body: some View {
        GeometryReader { geometry in
            @State var x: [Float] = []
            @State var y: [Float] = []
            
            let size = min(geometry.size.width, geometry.size.height) / 2
            let center = CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2)
            
            // Points for the triangle vertices
            let points = [
                CGPoint(x: center.x, y: center.y - size), // Top
                CGPoint(x: center.x - size * cos(.pi / 6), y: center.y + size / 2), // Left
                CGPoint(x: center.x + size * cos(.pi / 6), y: center.y + size / 2)  // Right
            ]
            
            let strokeWeights = calculateStrokeWidths()
            
            // Aperture to Shutter Speed
            Path { path in
                path.move(to: points[0])
                path.addLine(to: points[1])
            }
            .stroke(.gray, lineWidth: strokeWeights.aperture)

            // Shutter Speed to ISO
            Path { path in
                path.move(to: points[1])
                path.addLine(to: points[2])
            }
            .stroke(.gray, lineWidth: strokeWeights.shutterSpeed)
            
            // ISO to Aperture
            Path { path in
                path.move(to: points[2])
                path.addLine(to: points[0])
            }
            .stroke(.gray, lineWidth: strokeWeights.iso)

            Path { path in
                path.addEllipse(in: CGRect(x: points[0].x - 12, y: points[0].y - 12, width: 24, height: 24))
                path.addEllipse(in: CGRect(x: points[1].x - 12, y: points[1].y - 12, width: 24, height: 24))
                path.addEllipse(in: CGRect(x: points[2].x - 12, y: points[2].y - 12, width: 24, height: 24))
            }
            .fill(.primary)
            .stroke(.background, lineWidth: 6)
        
            
            Path { path in
                path.addEllipse(in: CGRect(x: center.x - 4, y: center.y - 4, width: 8, height: 8))
            }
            .fill(.blue)
            
            
            MarkersShape(
                point1: CGPoint(x: (points[0].x+points[1].x)/2, y: (points[0].y+points[1].y)/2),
                point2: CGPoint(x: (points[1].x+points[2].x)/2, y: (points[1].y+points[2].y)/2),
                point3: CGPoint(x: (points[2].x+points[0].x)/2, y: (points[2].y+points[0].y)/2),
                strength1: (strokeWeights.aperture - 0.9) * 1000000,
                strength2: (strokeWeights.shutterSpeed - 0.9) * 1000000,
                strength3: (strokeWeights.iso - 0.9) * 1000000,
                center: CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2)
            )
            .fill(.red)
            .stroke(.background, lineWidth: 6)
        }
    }
}

struct MarkersShape: Shape {
    var point1: CGPoint
    var point2: CGPoint
    var point3: CGPoint
    
    var strength1: CGFloat
    var strength2: CGFloat
    var strength3: CGFloat
    
    var center: CGPoint

    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        var weightedCenter: CGPoint {
            let totalStrength = strength1 + strength2 + strength3
            let weightedX = (point1.x * strength1 + point2.x * strength2 + point3.x * strength3) / totalStrength
            let weightedY = (point1.y * strength1 + point2.y * strength2 + point3.y * strength3) / totalStrength
            return CGPoint(x: weightedX, y: weightedY)
        }
        
        path.addEllipse(in: CGRect(x: weightedCenter.x - 12, y: weightedCenter.y - 12, width: 24, height: 24))

        
        return path
    }
}

extension Array where Element == CGPoint {
    /// Calculate signed area.
    ///
    /// See https://en.wikipedia.org/wiki/Centroid#Of_a_polygon
    ///
    /// - Returns: The signed area

    func signedArea() -> CGFloat {
        if isEmpty { return .zero }

        var sum: CGFloat = 0
        for (index, point) in enumerated() {
            let nextPoint: CGPoint
            if index < count-1 {
                nextPoint = self[index+1]
            } else {
                nextPoint = self[0]
            }

            sum += point.x * nextPoint.y - nextPoint.x * point.y
        }

        return sum / 2
    }

    /// Calculate centroid
    ///
    /// See https://en.wikipedia.org/wiki/Centroid#Of_a_polygon
    ///
    /// - Note: If the area of the polygon is zero (e.g. the points are collinear), this returns `nil`.
    ///
    /// - Parameter points: Unclosed points of polygon.
    /// - Returns: Centroid point.

    func centroid() -> CGPoint? {
        if isEmpty { return nil }

        let area = signedArea()
        if area == 0 { return nil }

        var sumPoint: CGPoint = .zero

        for (index, point) in enumerated() {
            let nextPoint: CGPoint
            if index < count-1 {
                nextPoint = self[index+1]
            } else {
                nextPoint = self[0]
            }

            let factor = point.x * nextPoint.y - nextPoint.x * point.y
            sumPoint.x += (point.x + nextPoint.x) * factor
            sumPoint.y += (point.y + nextPoint.y) * factor
        }

        return sumPoint / 6 / area
    }

    func mean() -> CGPoint? {
        if isEmpty { return nil }

        return reduce(.zero, +) / CGFloat(count)
    }
}

extension CGPoint {
    static func + (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }

    static func - (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
    }

    static func / (lhs: CGPoint, rhs: CGFloat) -> CGPoint {
        CGPoint(x: lhs.x / rhs, y: lhs.y / rhs)
    }

    static func * (lhs: CGPoint, rhs: CGFloat) -> CGPoint {
        CGPoint(x: lhs.x * rhs, y: lhs.y * rhs)
    }
}
