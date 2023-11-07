//
//  IconButtonComponent.swift
//  WorkItOut
//
//  Created by Jeremy Raymond on 07/11/23.
//

import SwiftUI

struct IconButtonComponent: View {
    var icon: String = "person"
    var action: () -> Void = {
        print("I'm a button")
    }
    
    var body: some View {
        Button(action: action) {
            Image(systemName: icon)
                .padding(12)
                .background(Color.background.opacity(0.5))
                .clipShape(.circle)
        }
        
    }
}

#Preview {
    IconButtonComponent()
}
