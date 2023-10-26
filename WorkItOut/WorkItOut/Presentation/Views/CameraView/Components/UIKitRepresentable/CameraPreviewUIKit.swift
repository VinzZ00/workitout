//
//  CameraPreviewUIKit.swift
//  WorkItOut
//
//  Created by Elvin Sestomi on 26/10/23.
//


import SwiftUI
import AVFoundation
import UIKit

struct CameraPreviewUIKit: UIViewRepresentable {
    
    let cameraManager : CameraDeviceManager;
    let size : CGSize
    
    init(cameraManager: CameraDeviceManager, size: CGSize) {
        self.cameraManager = cameraManager
        self.size = size
    }
    
    func makeUIView(context: Context) -> some UIView {
        
        let root =  UIView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: size));
        
        let cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: self.cameraManager.session)
      
        cameraPreviewLayer.videoGravity = .resizeAspectFill
        cameraPreviewLayer.frame = root.bounds
        
//        cameraPreviewLayer.connection?.videoOrientation = .portrait

        root.layer.addSublayer(cameraPreviewLayer)
        
        return root
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {  }
    

}
