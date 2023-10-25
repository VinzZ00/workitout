//
//  SliderComponent.swift
//  WorkItOut
//
//  Created by Jeremy Raymond on 24/10/23.
//

import SwiftUI

struct SliderComponent: View {
    var title: String
    @Binding var value: Double
    var measurementUnit: String
    
    var minRange: Int
    var maxRange: Int
    
    var body: some View {
        VStack() {
            HStack {
                Text(title)
                Spacer()
            }
            Slider(
                value: $value,
                in: Double(minRange)...Double(maxRange)
            )
            Text("\(Int(value)) \(measurementUnit)")
        }
    }
}

#Preview {
    SliderComponent(title: "Title", value: .constant(150), measurementUnit: "cm", minRange: 100, maxRange: 200)
}
