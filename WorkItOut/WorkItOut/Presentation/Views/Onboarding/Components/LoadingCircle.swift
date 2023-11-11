//
//  LoadingCircle.swift
//  WorkItOut
//
//  Created by Kevin Dallian on 25/10/23.
//

import SwiftUI

struct LoadingCircle: View {
    @State var buttonPressed : Bool = false
    
    private let gradient = AngularGradient(
        gradient: Gradient(colors: [Color.primary, .clear]),
        center: .center,
        startAngle: .degrees(270),
        endAngle: .degrees(0)
    )
    
    private var foreverAnimation : Animation {
        Animation.linear(duration: 2.0)
            .repeatForever(autoreverses: false)
    }
    
    var body: some View {
        VStack{
            ZStack{
                Circle()
                    .trim(from: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, to: 0.75)
                    .stroke(gradient ,style: StrokeStyle(lineWidth: 32,lineCap: .round))
                    .frame(width: 200)
                    .rotationEffect(buttonPressed ? .degrees(0) : .degrees(-360))
                    .animation(foreverAnimation, value: buttonPressed)
                    
            }
        }
        .onAppear{
            buttonPressed = true
        }
    }
}

#Preview {
    LoadingCircle()
}
