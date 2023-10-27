//
//  VisionRequestManager.swift
//  WorkItOut
//
//  Created by Elvin Sestomi on 26/10/23.
//

import Foundation
import Vision
import Combine
import UIKit

class CameraViewModel : ObservableObject {
    
    var points : CurrentValueSubject<[VNHumanBodyPoseObservation.JointName : (CGPoint, CGFloat)], Never> = CurrentValueSubject<[VNHumanBodyPoseObservation.JointName : (CGPoint, CGFloat)], Never>([ : ])
    var bag : [AnyCancellable] = [];
//    @Published var points : [VNHumanBodyPoseObservation.JointName : (CGPoint, CGFloat)] = [:]
    @Published var visionRequest : VNDetectHumanBodyPoseRequest!

    var keyPoints : [VNHumanBodyPoseObservation.JointName] =
    [
            .leftAnkle,
            .leftKnee,
            .leftHip,
            .leftShoulder,
            .leftElbow,
            .leftWrist,
            .rightAnkle,
            .rightKnee,
            .rightHip,
            .rightShoulder,
            .rightElbow,
            .rightWrist
            
    ]
    
    @MainActor func humanBodyRequest(previewSize : CGSize) {
        self.visionRequest = VNDetectHumanBodyPoseRequest { req, err in
            if err != nil {
                fatalError(" Error Dibagian completion Hander VNRequestNya, Error : \(err!.localizedDescription)")
            }
            
            guard let observation = req.results as? [VNHumanBodyPoseObservation] else {
                fatalError("Failed to convert result menjadi [VNHumanBodyPoseObservation]")
            }
            
            var points : [VNHumanBodyPoseObservation.JointName : (CGPoint, CGFloat)] = [:]
            
            
            self.keyPoints.forEach {  kp in
                do {
                    if observation.count > 0 {
                        guard let recPoint = try observation.first?.recognizedPoint(kp) else {
                            print("gaad Keypoint dengan nama : \(kp)")
                            return
                        }
                        
                        if recPoint.confidence > 0.1 {
                            let realPoint : CGPoint = self.normalizePoint(recognizedPoint: recPoint, previewSize: previewSize)
                            
                            if realPoint.y != 0 && realPoint.x != 0 {
//                                print("Normalized Keypoint : \(realPoint)")
                                points[kp] = (realPoint, CGFloat(recPoint.confidence))
                                self.points.send(points) 
                            }
                        }
                    }
                } catch {
                    
                }
            }
        }
//        return humanBodyRequest
    }
    
    func normalizePoint(recognizedPoint : VNRecognizedPoint, previewSize : CGSize) -> CGPoint {
        let normPoint = VNImagePointForNormalizedPoint(recognizedPoint.location, Int(previewSize.width), Int(previewSize.height))
        
        let realPoint : CGPoint
        
        if UIDevice.current.orientation == .landscapeRight {
            realPoint = CGPoint(x: normPoint.y - 34, y: previewSize
                .width - normPoint.x)
        } else if UIDevice.current.orientation == .landscapeLeft {
            realPoint = CGPoint(x: previewSize.height - normPoint.y - 34, y: normPoint.x)
        } else {
            realPoint = CGPoint(x: previewSize
                .width - normPoint.x, y: previewSize
                .height - normPoint.y - 34)
        }
        
        return realPoint
    }
}
