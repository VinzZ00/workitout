//
//  YogaDetailView.swift
//  WorkItOut
//
//  Created by Jeremy Raymond on 31/10/23.
//

import SwiftUI

struct YogaDetailView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Image(systemName: "xmark")
            Text("Balancing and Grounding")
            Text("5 Exercise (50 Min)")
            ForEach(0...5, id: \.self) { _ in
                YogaCardView()
            }
            ButtonComponent(title: "Start Now") {
                //
            }
        }
    }
}

#Preview {
    YogaDetailView()
}
