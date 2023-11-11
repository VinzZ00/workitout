//
//  ButtonComponent.swift
//  WorkItOut
//
//  Created by Jeremy Raymond on 24/10/23.
//

import SwiftUI

struct ButtonComponent: View {
    var title: LocalizedStringResource = "Next"
    var role : ButtonRole? = .none
    var color : Color = Color.primary
    var action: () -> Void = {
        print("I'm a button")
    }
    
    var body: some View {
        Button(role: role, action: action) {
            Text(title)
                .bold()
                .padding(.vertical, 4)
                .frame(maxWidth: .infinity)
        }
        .padding(.vertical)
        .tint(self.color)
        .buttonStyle(.borderedProminent)
    }
}

#Preview {
    ButtonComponent()
}
