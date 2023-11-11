//
//  ButtonStyles.swift
//  WorkItOut
//
//  Created by Kevin Dallian on 25/10/23.
//

import Foundation
import SwiftUI

struct BorderedButton : ButtonStyle {
    func makeBody(configuration : Configuration) -> some View {
        configuration.label
            .bold()
            .padding(.vertical, 10)
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
            .background(configuration.isPressed ? .white : Color.primary)
            .foregroundStyle(.white)
            .clipShape(RoundedRectangle(cornerRadius: 5))
            .animation(.easeOut(duration: 0.15), value: configuration.isPressed)
            .padding(.horizontal)
    }
}

struct OutlineButton : ButtonStyle {
    func makeBody(configuration : Configuration) -> some View {
        configuration.label
            .bold()
            .padding(.vertical, 10)
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
            .foregroundStyle(configuration.isPressed ? .white : .gray)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(configuration.isPressed ? .white : .gray, lineWidth: 0.5)
            )
            .buttonBorderShape(.roundedRectangle(radius: 12))
            .animation(.easeOut(duration: 0.15), value: configuration.isPressed)
            .padding(.horizontal)
    }
}


struct BorderedDisabledButton : ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .bold()
            .padding(.vertical, 10)
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
            .background(Color.primary.opacity(0.5))
            .foregroundStyle(.white)
            .clipShape(RoundedRectangle(cornerRadius: 5))
            .padding(.horizontal)
    }
}

#Preview {
    Button(""){
        
    }
}
