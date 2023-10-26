//
//  bodyPoints.swift
//  Macro-Challenge-Wawiwuwiwaw
//
//  Created by Elvin Sestomi on 29/09/23.
//

import Foundation
import SwiftUI
import Vision

struct BodyPointCircle : Shape {
    
//    var points : [VNHumanBodyPoseObservation.JointName : CGPoint]

    var points : [CGPoint]
    
    func path(in rect: CGRect) -> Path {
        var p = Path()
        var points : [CGPoint] = []
        
//        self.points.values.forEach { pt in
//            points.append(pt)
//        }
        
        self.points.forEach { pt in
            points.append(pt)
        }
        
        for pt in 0...points.count - 1 {
            p.move(to: points[pt])
            p.addArc(center: points[pt], radius: 20, startAngle: .degrees(0), endAngle: .degrees(360), clockwise: true)
        }
        
        return p
    }
    
}
