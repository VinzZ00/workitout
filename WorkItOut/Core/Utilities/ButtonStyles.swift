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
            .background(configuration.isPressed ? .white : .orangePrimary)
            .foregroundStyle(.white)
            .clipShape(RoundedRectangle(cornerRadius: 5))
            .animation(.easeOut(duration: 0.15), value: configuration.isPressed)
    }
}

struct BorderedDisabledButton : ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .bold()
            .padding(.vertical, 10)
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
            .background(.white)
            .foregroundStyle(.white)
            .clipShape(RoundedRectangle(cornerRadius: 5))
    }
}

#Preview {
    AssessmentView()
}
