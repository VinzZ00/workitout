//
//  TestMatchedGeometryView.swift
//  Mamaste
//
//  Created by Jeremy Raymond on 15/11/23.
//

import SwiftUI

struct TestMatchedGeometryView: View {
    @State var selected: Color = .red
    let colors: [Color] = [.red, .blue, .green]
    
    @Namespace private var animation
    
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
            
            LazyHStack {
                ForEach(colors, id: \.self) { color in
                    if selected == color {
                        Rectangle()
                            .fill(color)
                            .clipShape(.rect(cornerRadius: 12))
                            .frame(width: 360)
                            .matchedGeometryEffect(id: "animationID", in: animation)
                    }
                }
            }
        }
        .padding()
        .animation(.easeInOut, value: selected)
    }
}

#Preview {
    TestMatchedGeometryView()
}
