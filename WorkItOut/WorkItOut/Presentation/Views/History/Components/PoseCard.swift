//
//  PoseCard.swift
//  WorkItOut
//
//  Created by Kevin Dallian on 03/11/23.
//

import SwiftUI

struct PoseCard: View {
    var pose : Pose
    var body: some View {
        HStack{
            if let image = pose.image{
                Image(image)
                    .resizable()
                    .frame(width: 70, height: 70)
                    .padding(.trailing, 10)
            }else{
                RoundedRectangle(cornerRadius: 12)
                    .frame(width: 70, height: 70)
                    .padding(.trailing, 10)
            }
            VStack(alignment: .leading){
                Text("\(pose.name)")
                    .bold()
                Text("\(pose.category.rawValue)")
                    .foregroundStyle(Color.neutral6)
                    .font(.caption)
            }
            Spacer()
            if pose.state == .completed {
                Image(systemName: "checkmark")
                    .resizable()
                    .frame(width: 12, height: 10)
                    .foregroundStyle(.green)
            }else{
                Text("x")
                    .foregroundStyle(.red)
            }
        }
    }
}

#Preview {
    VStack(spacing: 20){
        Text("Completed State")
            .bold()
        PoseCard(pose : Pose(id: UUID(), name: "Banana", difficulty: .beginner, recommendedTrimester: .all, relieve: [.back, .neck, .hip], image: nil, description: "Banana", seconds: 60, state: .completed))
        Text("Skipped State")
            .bold()
        PoseCard(pose : Pose(id: UUID(), name: "Banana", difficulty: .beginner, recommendedTrimester: .all, relieve: [.back, .neck, .hip], image: nil, description: "Banana", seconds: 60, state: .completed))
    }
}
