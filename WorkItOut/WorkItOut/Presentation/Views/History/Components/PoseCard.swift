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
            if let _ = UIImage(named: pose.name){
                PoseImageCard(name: pose.name, width: 70)
            }else{
                RoundedRectangle(cornerRadius: 12)
                    .frame(width: 70, height: 70)
                    .padding(.trailing, 10)
            }
            VStack(alignment: .leading){
                Text("\(pose.name)")
                    .bold()
                HStack(spacing: 5){
                    Image(systemName: "clock")
                        .font(.caption)
                        .foregroundStyle(Color.neutral3)
                    Text("\(pose.seconds/60) min")
                        .font(.caption)
                        .foregroundStyle(Color.neutral3)
                }
                Text("\(pose.category.rawValue)")
                    .foregroundStyle(Color.neutral3)
                    .font(.caption)
            }
            Spacer()
            if pose.state == .completed {
                Image(systemName: "checkmark")
                    .resizable()
                    .frame(width: 12, height: 10)
                    .foregroundStyle(.green)
            }else{
                Image(systemName: "multiply")
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
        PoseCard(pose : Pose(id: UUID(), name: "Banana", difficulty: .beginner, recommendedTrimester: .all, relieve: [.back, .neck, .hip], image: nil, description: "Banana", seconds: 60, state: .skipped))
    }
}
