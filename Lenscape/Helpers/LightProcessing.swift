//
//  LightProcessing.swift
//  Lenscape
//
//  Created by Jude Wilson on 4/9/24.
//

import CoreImage
import AVFoundation

extension CMSampleBuffer {
    func calculateAverageBrightness() -> Double? {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(self) else { return nil }
        let ciImage = CIImage(cvPixelBuffer: pixelBuffer)
        let context = CIContext(options: nil)
        guard let cgImage = context.createCGImage(ciImage, from: ciImage.extent) else { return nil }
        
        let imageData = cgImage.dataProvider?.data
        guard let data = CFDataGetBytePtr(imageData) else { return nil }
        
        var brightnessTotal: Double = 0
        let height = cgImage.height
        let width = cgImage.width
        let bytesPerRow = cgImage.bytesPerRow
        let bytesPerPixel = 4
        for row in 0..<height {
            for col in 0..<width {
                let pixelOffset = row * bytesPerRow + col * bytesPerPixel
                let r = data[pixelOffset]
                let g = data[pixelOffset + 1]
                let b = data[pixelOffset + 2]
                
                // Luminosity formula to calculate brightness of a pixel
                let luminance = 0.2126 * Double(r) + 0.7152 * Double(g) + 0.0722 * Double(b)
                brightnessTotal += luminance
            }
        }
        
        let pixelCount = width * height
        let averageLuminance = brightnessTotal / Double(pixelCount)
        
        // Normalize the luminance to a 0-1 scale
        let normalizedLuminance = averageLuminance / 255.0
        
        return normalizedLuminance
    }
}
