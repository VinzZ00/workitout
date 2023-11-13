//
//  YogaCardView.swift
//  WorkItOut
//
//  Created by Jeremy Raymond on 30/10/23.
//

import SwiftUI

struct YogaCardView: View {
    var name: String = "Mountain Pose (Tadasana)"
    var description: String = "Help relieve back pain"
    var min: Int = 10
    
    var body: some View {
        HStack {
            if UIImage(named: name) != nil{
                PoseImageCard(name: name, width: 70)
            }else{
                Rectangle()
                    .foregroundStyle(.purple)
                    .frame(width: 70, height: 70)
                    .clipShape(.rect(cornerRadius: 12))
            }
            VStack(alignment: .leading) {
                Text(name)
                    .font(.title3)
                    .bold()
                Text("\(min) Min")
                    .font(.subheadline)
                    .padding(6)
                    .background(Color.neutral6.opacity(0.5))
                    .clipShape(.rect(cornerRadius: 10))
                Text(description)
                    .foregroundStyle(Color.neutral3)
                    .font(.subheadline)
            }
        }
    }
}

#Preview {
    YogaCardView(name: "Mountain")
}
