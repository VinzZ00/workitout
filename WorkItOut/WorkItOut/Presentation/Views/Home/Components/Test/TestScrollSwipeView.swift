//
//  TestScrollSwipeView.swift
//  Mamaste
//
//  Created by Jeremy Raymond on 15/11/23.
//

import SwiftUI

struct TestScrollSwipeView: View {
    @State var selected: Color = .red
    @State var scrollPosition: Color?
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
                .contentTransition(.identity)
            ScrollView(.horizontal) {
                LazyHStack {
                    ForEach(colors, id: \.self) { color in
                        Rectangle()
                            .fill(color)
                            .clipShape(.rect(cornerRadius: 12))
                            .frame(width: 360)
                            .transition(.opacity.combined(with: .move(edge: .bottom)))
                    }
                }
                .scrollTargetLayout()
            }
            .scrollTargetBehavior(.viewAligned)
            .scrollPosition(id: $scrollPosition)
        }
        .padding()
        .onChange(of: selected) { oldValue, newValue in
            withAnimation {
                scrollPosition = selected
            }
        }
        .onChange(of: scrollPosition) { oldValue, newValue in
            withAnimation {
                if let scrollPosition {
                    selected = scrollPosition
                }
            }
        }
    }
}

#Preview {
    TestScrollSwipeView()
}
