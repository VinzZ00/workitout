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



class SampleBufferOutputDelegate : NSObject, AVCaptureVideoDataOutputSampleBufferDelegate{
    
    var visionRequest : VNDetectHumanBodyPoseRequest!

    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            return
        }
        
        let outputConnection = output.connection(with: .video)
        outputConnection?.videoOrientation = .portrait
        
        print("Output Connection: \(String(describing: outputConnection?.videoOrientation))")
        
        let ciImage = CIImage(cvPixelBuffer: pixelBuffer)
        
        let requestHandler = VNImageRequestHandler(ciImage: ciImage)
        
        do {
            try requestHandler.perform([self.visionRequest]);
        } catch {
            fatalError("Error di bagian capture output functon dari vision request")
        }
        
    }
}
