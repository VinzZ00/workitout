//
//  ButtonComponent.swift
//  WorkItOut
//
//  Created by Jeremy Raymond on 24/10/23.
//

import SwiftUI

struct ButtonComponent: View {
    var title: String
    var role : ButtonRole?
    var action: () -> Void
    var color : Color
    
    init(title: String, role: ButtonRole? = nil, color : Color = .orangePrimary, action: @escaping () -> Void) {
        self.title = title
        self.role = role
        self.color = color
        self.action = action
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
    ButtonComponent(title: "Submit", role: .none) {
        print("I'm a button")
    }
}
