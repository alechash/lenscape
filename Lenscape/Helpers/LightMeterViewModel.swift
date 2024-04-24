//
//  LightMeterViewModel.swift
//  Lenscape
//
//  Created by Jude Wilson on 4/9/24.
//

import Foundation
import AVFoundation

struct CameraSettings {
    var aperture: String
    var shutterSpeed: String
    var iso: String
}

// Baseline settings for different brightness levels (these are examples; adjust based on real-world testing)
let lowLightSettings = CameraSettings(aperture: "f/2.8", shutterSpeed: "1/1", iso: "800")
let mediumLightSettings = CameraSettings(aperture: "f/8", shutterSpeed: "1/500", iso: "200")
let highLightSettings = CameraSettings(aperture: "f/16", shutterSpeed: "1/1000", iso: "100")

let standardApertures: [Double] = [1.4, 2.0, 2.8, 4.0, 5.6, 8.0, 11.0, 16.0, 22.0]
let standardShutterSpeeds: [Double] = [4000, 2000, 1000, 500, 250, 125, 60, 30, 15, 8, 4, 2, 1]
let standardISOs: [Double] = [100, 200, 300, 400, 800, 1600, 3200, 6400]

func interpolateSettings(for brightness: Double) -> CameraSettings {
    // Assuming brightness ranges from 0 (low) to 1 (high)
    if brightness <= 0.3 {
        return lowLightSettings
    } else if brightness >= 0.7 {
        return highLightSettings
    } else {
        // Interpolate between medium and high or medium and low based on brightness
        let mediumToHighRatio = (brightness - 0.3) / 0.4 // Scale between 0.3 and 0.7
        
        let interpolatedAperture = interpolate(value: mediumToHighRatio, from: [2.8, 16.0])
        let interpolatedShutterSpeed = interpolate(value: mediumToHighRatio, from: [1, 1000])
        let interpolatedISO = interpolate(value: mediumToHighRatio, from: [800.0, 100.0])
        
        let aperture = nearestStandardValue(for: interpolatedAperture, in: standardApertures)
        let shutterSpeed = nearestStandardShutterSpeed(for: interpolatedShutterSpeed)
        let iso = nearestStandardValue(for: interpolatedISO, in: standardISOs)
        
        return CameraSettings(aperture: "f/\(aperture)", shutterSpeed: "1/\(Int(shutterSpeed))", iso: "\(iso)")
    }
}

func nearestStandardValue(for value: Double, in standardValues: [Double]) -> Double {
    return standardValues.min(by: { abs($0 - value) < abs($1 - value) }) ?? value
}

func nearestStandardShutterSpeed(for value: Double) -> Double {
    let inverseValues = standardShutterSpeeds.map { 1 / $0 } // Convert to inverse for comparison
    let inverseValue = 1 / value
    let nearestInverse = nearestStandardValue(for: inverseValue, in: inverseValues)
    return 1 / nearestInverse
}


func interpolate(value: Double, from range: [Double]) -> Double {
    let delta = range[1] - range[0]
    return range[0] + delta * value
}


class LightMeterViewModel: NSObject, ObservableObject, AVCaptureVideoDataOutputSampleBufferDelegate {
    let captureSession = AVCaptureSession()
    
    private let videoOutput = AVCaptureVideoDataOutput()
    
    @Published var ambientLightDescription = "Waiting..."
    @Published var recommendedAperture = "f/2.8"
    @Published var recommendedShutterSpeed = "1/60"
    @Published var recommendedISO = "100"
    
    override init() {
        super.init()
        setupCamera()
    }
    
    private func setupCamera() {
        guard let device = AVCaptureDevice.default(for: .video),
              let input = try? AVCaptureDeviceInput(device: device) else {
            ambientLightDescription = "Camera not available"
            return
        }
        
        captureSession.addInput(input)
        videoOutput.videoSettings = [(kCVPixelBufferPixelFormatTypeKey as String): NSNumber(value: kCVPixelFormatType_32BGRA)]
        videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "lightMeterQueue"))
        captureSession.addOutput(videoOutput)
    }
    
    func startCapturing() {
        if !captureSession.isRunning {
            DispatchQueue(label: "background_queue", qos: .background).async {
                self.captureSession.startRunning()
            }
        }
    }
    
    func stopCapturing() {
        if captureSession.isRunning {
            captureSession.stopRunning()
        }
    }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let averageBrightness = sampleBuffer.calculateAverageBrightness() else { return }
        
        let settings = interpolateSettings(for: averageBrightness)
        
        DispatchQueue.main.async {
            self.ambientLightDescription = "\(String(format: "%.2f", averageBrightness*100))%"
            
            // Example adjustments based on brightness
            self.recommendedAperture = settings.aperture
            self.recommendedShutterSpeed = settings.shutterSpeed
            self.recommendedISO = settings.iso.split(separator: ".", maxSplits: 1).map(String.init)[0]
        }
    }

}

