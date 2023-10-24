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
    
    var body: some View {
        Button(role: role, action: action) {
            Text(title)
                .padding(.vertical, 4)
                .frame(maxWidth: .infinity)
        }
        .padding(.vertical)
        .buttonStyle(.borderedProminent)
    }
}

#Preview {
    ButtonComponent(title: "Submit", role: .none) {
        print("I'm a button")
    }
}
