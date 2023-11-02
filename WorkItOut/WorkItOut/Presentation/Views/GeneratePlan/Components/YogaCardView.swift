//
//  YogaCardView.swift
//  WorkItOut
//
//  Created by Jeremy Raymond on 30/10/23.
//

import SwiftUI

struct YogaCardView: View {
    var name: String = "Mountain Pose (Tadasana)"
    var category: String = "Category Item"
    var min: Int = 10
    
    var body: some View {
        HStack {
            Rectangle()
                .foregroundStyle(.purple)
                .frame(width: 70, height: 70)
                .clipShape(.rect(cornerRadius: 12))
            VStack(alignment: .leading) {
                Text(name)
                    .font(.title3)
                    .bold()
                Text(category)
                    .foregroundStyle(.neutral3)
                    .font(.body)
            }
            Spacer()
            Text("\(min) min")
                .padding(8)
                .background(.neutral6)
                .clipShape(.rect(cornerRadius: 12))
        }
    }
}

#Preview {
    YogaCardView()
}
