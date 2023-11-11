//
//  CheckBox.swift
//  WorkItOut
//
//  Created by Kevin Dallian on 10/11/23.
//

import SwiftUI

struct CheckBox: View {
    @Binding var toggle : Bool
    var text : String
    
    init(_ text: String, toggle: Binding<Bool>) {
        self._toggle = toggle
        self.text = text
    }
    var body: some View {
        HStack{
            Button {
                toggle.toggle()
            } label: {
                HStack{
                    Image(systemName: toggle ? "checkmark.square" : "square")
                        .font(.title2)
                        .foregroundStyle(Color.neutral4)
                }
            }
            Text(text)
                .foregroundStyle(Color.neutral4)
        }
    }
}

#Preview {
    VStack{
        CheckBox("Text for Checkbox", toggle: .constant(true))
        CheckBox("Text for Checkbox", toggle: .constant(false))
    }
}
