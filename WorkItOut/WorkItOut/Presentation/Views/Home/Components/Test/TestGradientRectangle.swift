//
//  TestGradientRectangle.swift
//  Mamaste
//
//  Created by Jeremy Raymond on 18/11/23.
//

import SwiftUI

struct GradientRectangle: View {
    var width: Double = 240
    
    var body: some View {
        Rectangle()
            .fill(
                LinearGradient(
                    colors: [.purple, .clear], startPoint: .bottom, endPoint: .top
                )
            )
            .blur(radius: 20)
            .opacity(0.5)
            .frame(width: width)
            .frame(maxHeight: .infinity)
    }
}

struct TestGradientRectangle: View {
    @Binding var picker: Trimester
    
    var body: some View {
        VStack {
            ZStack {
                if picker == .first {
                    GradientRectangle(width: 220)
                }
                else if picker == .second {
                    HStack {
                        Spacer()
                        GradientRectangle(width: 140)
                        Spacer()
                        GradientRectangle(width: 140)
                        Spacer()
                    }
                    
                }
                else if picker == .third {
                    HStack {
                        GradientRectangle(width: 120)
                        Spacer()
                        GradientRectangle(width: 120)
                        Spacer()
                        GradientRectangle(width: 120)
                    }
                    .ignoresSafeArea()
                }
            }
            
        }
        .ignoresSafeArea(edges: [.bottom, .top])
        .animation(.easeInOut, value: picker)
    }
}

#Preview {
    TestGradientRectangle(picker: .constant(.first))
}
