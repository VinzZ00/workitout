//
//  YogaCardView.swift
//  WorkItOut
//
//  Created by Jeremy Raymond on 30/10/23.
//

import SwiftUI

struct YogaCardView: View {
    var body: some View {
        HStack {
            Rectangle()
                .foregroundStyle(.purple)
                .frame(width: 70, height: 70)
                .clipShape(.rect(cornerRadius: 12))
            VStack(alignment: .leading) {
                Text("Mountain Pose (Tadasana)")
                    .font(.title3)
                    .bold()
                Text("Category Item")
                    .font(.body)
            }
            Text("10 min")
                .padding(8)
                .background(.gray)
                .clipShape(.rect(cornerRadius: 12))
        }
    }
}

#Preview {
    YogaCardView()
}
