//
//  SampleBufferOutputDelegate.swift
//  WorkItOut
//
//  Created by Elvin Sestomi on 26/10/23.
//

import Foundation
import Vision
import AVFoundation
import CoreImage



class sampleBufferOutputDelegate : NSObject, AVCaptureVideoDataOutputSampleBufferDelegate {
    
    var visionRequest : VNRequest;
    var videoOrientation : AVCaptureVideoOrientation = .portrait
    
    init(visionRequest : VNRequest) {
        self.visionRequest = visionRequest
    }
    
    
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            return
        }
        
        let outputConnection = output.connection(with: .video)
        outputConnection?.videoOrientation = videoOrientation
        
        print("Output Connection: \(String(describing: outputConnection?.videoOrientation))")
        
        let ciImage = CIImage(cvPixelBuffer: pixelBuffer)
        
        let requestHandler = VNImageRequestHandler(ciImage: ciImage)
        
        do {
            try requestHandler.perform([self.visionRequest]);
        } catch {
            fatalError("Error di bagian capture output funciton dari vision request")
        }
        
    }
}
