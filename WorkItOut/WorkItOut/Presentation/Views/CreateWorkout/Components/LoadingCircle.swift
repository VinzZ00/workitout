//
//  LoadingCircle.swift
//  WorkItOut
//
//  Created by Kevin Dallian on 25/10/23.
//

import SwiftUI

struct LoadingCircle: View {
    @State var buttonPressed : Bool = false
    var foreverAnimation : Animation {
        Animation.linear(duration: 2.0)
            .repeatForever(autoreverses: false)
    }
    var body: some View {
        VStack{
            ZStack{
                Circle()
                    .stroke(lineWidth: 40)
                    .foregroundStyle(.grayBorder)
                    .frame(width: 200)
                Circle()
                    .trim(from: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, to: 0.5)
                    .stroke(style: StrokeStyle(lineWidth: 40,lineCap: .round))
                    .foregroundStyle(.orangePrimary)
                    .frame(width: 200)
                    .rotationEffect(buttonPressed ? .degrees(-25) : .degrees(-385))
                    .animation(buttonPressed ? foreverAnimation : .default)
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
