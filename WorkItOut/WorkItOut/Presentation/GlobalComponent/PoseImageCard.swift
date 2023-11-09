//
//  PoseImageCard.swift
//  WorkItOut
//
//  Created by Kevin Dallian on 09/11/23.
//

import SwiftUI

struct PoseImageCard: View {
    var name : String
    var width : CGFloat
    var body: some View {
        Image(name)
            .resizable()
            .scaledToFill()
            .frame(width: width, height: width)
            .cornerRadius(12)
            .clipped()
    }
}

#Preview {
    PoseImageCard(name: "Mountain", width: 150)
}
