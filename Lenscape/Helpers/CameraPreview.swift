//
//  CameraPreview.swift
//  Lenscape
//
//  Created by Jude Wilson on 4/9/24.
//

import SwiftUI
import AVFoundation

struct CameraPreview: UIViewRepresentable {
    let session: AVCaptureSession
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: UIScreen.main.bounds)
        
        // Create and configure the preview layer.
        let previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)
        
        NotificationCenter.default.addObserver(forName: UIDevice.orientationDidChangeNotification, object: nil, queue: .main) { _ in
            // Update orientation
            let orientation = UIDevice.current.orientation
            
            if let connection = previewLayer.connection, connection.isVideoOrientationSupported {
                connection.videoOrientation = orientation.toVideoOrientation()
            }
            
            previewLayer.videoGravity = .resizeAspectFill
            view.layer.addSublayer(previewLayer)
        }
        
        let orientation = UIDevice.current.orientation
        
        if let connection = previewLayer.connection, connection.isVideoOrientationSupported {
            connection.videoOrientation = orientation.toVideoOrientation()
        }
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {}
}

extension UIDeviceOrientation {
    func toVideoOrientation() -> AVCaptureVideoOrientation {
        switch self {
        case .portrait: return .portrait
        case .landscapeRight: return .landscapeLeft
        case .landscapeLeft: return .landscapeRight
        case .portraitUpsideDown: return .portraitUpsideDown
        default: return .portrait
        }
    }
}
