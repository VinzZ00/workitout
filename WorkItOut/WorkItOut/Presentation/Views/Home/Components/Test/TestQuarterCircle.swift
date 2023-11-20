//
//  TestQuarterCircle.swift
//  Mamaste
//
//  Created by Jeremy Raymond on 18/11/23.
//

import SwiftUI

struct PieSegment: Shape {
    var start: Angle
    var end: Angle

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        path.move(to: center)
        path.addArc(center: center, radius: rect.midX, startAngle: start, endAngle: end, clockwise: false)
        return path
    }
}

struct TestQuarterCircle: View {
    var body: some View {
        VStack {
            PieSegment(start: .zero, end: .degrees(360))
        }
        .ignoresSafeArea()
    }
}

#Preview {
    TestQuarterCircle()
}
