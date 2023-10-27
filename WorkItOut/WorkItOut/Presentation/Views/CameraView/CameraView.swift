//
//  CameraView.swift
//  WorkItOut
//
//  Created by Elvin Sestomi on 26/10/23.
//

import SwiftUI
import Vision
import Combine

struct CameraView: View {
    
    @StateObject var viewModel = CameraViewModel()
    @State var points : [VNHumanBodyPoseObservation.JointName : (CGPoint, CGFloat)] = [:]
    
    
    
    var cameraDeviceManager : CameraDeviceManager = CameraDeviceManager()
    var outputDelegate = SampleBufferOutputDelegate()
    
    var body: some View {
        ZStack{
            GeometryReader { prox in
                CameraPreviewUIKit(cameraManager: self.cameraDeviceManager, size: prox.size)
                    .onAppear {
                        self.viewModel.humanBodyRequest(previewSize: prox.size)
                        self.outputDelegate.visionRequest = viewModel.visionRequest
                        cameraDeviceManager.setup(outputBufferDelegate: outputDelegate)
                    }
                
            }.ignoresSafeArea()
            
            if points.count > 1 {
                BodyPointCircle(points: points.values.map { $0.0 })
            }
            
        }.onAppear{
            viewModel.points.sink { pts in
                self.points = pts
            }.store(in: &viewModel.bag)
        }
    }
}

#Preview {
    CameraView()
}
