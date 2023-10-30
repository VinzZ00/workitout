//
//  AVfoundation.swift
//  VisionVSCoreML
//
//  Created by Elvin Sestomi on 21/09/23.
//

import Foundation
import AVFoundation
import Vision

class CameraDeviceManager {
    var session : AVCaptureSession = AVCaptureSession()
    var device : AVCaptureDevice!
    var input : AVCaptureDeviceInput!
    var output : AVCaptureVideoDataOutput!
    
    func setup(outputBufferDelegate : SampleBufferOutputDelegate) {
        guard let device = AVCaptureDevice.default(.builtInWideAngleCamera,
                                                   for : .video,
                                                   position: .front) else {
            fatalError("device tidak ketemu")
        }
        self.device = device
        
        self.output = AVCaptureVideoDataOutput()
        self.output.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String: Int(kCVPixelFormatType_420YpCbCr8BiPlanarFullRange)]
        
        
        
        self.output.setSampleBufferDelegate(outputBufferDelegate, queue: DispatchQueue(label: "videoOutputQueue"))
        
        IOSetup()
        
        
    }
    
    func IOSetup() {
        do {
            self.input = try AVCaptureDeviceInput(device: device)
        } catch let err {
            print("Eror pass ambil input dari device Error: \(err.localizedDescription)")
        }
        
        if self.session.canAddInput(self.input) {
            session.addInput(self.input)
        }
        
    


        
        if self.session.canAddOutput(self.output) {
            session.addOutput(self.output)
        } else {
            print("output Doesn't added")
        }
        
        
        Task {
            self.session.startRunning()
        }
    }
    
    
}

