//
//  CameraView.swift
//  WorkItOut
//
//  Created by Elvin Sestomi on 26/10/23.
//

import SwiftUI

struct CameraView: View {
    
    @StateObject var visionRequestManager = VisionRequestManager()
    var cameraDeviceManager : CameraDeviceManager = CameraDeviceManager()
    
    
    var body: some View {
        ZStack{
            GeometryReader { prox in
                CameraPreviewUIKit(cameraManager: self.cameraDeviceManager, size: prox.size)
                    .onAppear {
                        let vnreq = visionRequestManager.humanBodyRequest(previewSize: prox.size)
                        
                        var cameraDele = sampleBufferOutputDelegate(visionRequest: vnreq)
                        
                        self.cameraDeviceManager.setup(outputBufferDelegate: cameraDele)
                    }
            }
            
            if visionRequestManager.points.count > 1 {
                BodyPointCircle(points: visionRequestManager.points.values.map { $0.0 })
            }
            
        }
    }
}

#Preview {
    CameraView()
}
