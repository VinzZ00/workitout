//
//  TestAppearView.swift
//  Mamaste
//
//  Created by Jeremy Raymond on 15/11/23.
//

import SwiftUI

struct TestAppearView: View {
    @State var selected: Color = .red
    let colors: [Color] = [.red, .blue, .green]
    
    var body: some View {
        VStack {
            Picker("Color Picker", selection: $selected) {
                ForEach(colors, id: \.self) { color in
                    Text(color.description).tag(color)
                }
            }
            .pickerStyle(.segmented)
            
            Text(selected.description)
                .font(.largeTitle)
//                .contentTransition(.opacity)
//                .contentTransition(.identity)
                .contentTransition(.numericText())
            
            LazyHStack {
                ForEach(colors, id: \.self) { color in
                    if selected == color {
                        Rectangle()
                            .fill(color)
                            .clipShape(.rect(cornerRadius: 12))
                            .frame(width: 360)
//                            .transition(.opacity)
                            .transition(.opacity.combined(with: .move(edge: .bottom)))
//                            .transition(.move(edge: .bottom))
                    }
                }
            }
        }
        .padding()
        .animation(.easeInOut, value: selected)
    }
}

#Preview {
    TestAppearView()
}
