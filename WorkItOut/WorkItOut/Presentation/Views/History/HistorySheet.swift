//
//  HistorySheet.swift
//  WorkItOut
//
//  Created by Kevin Dallian on 02/11/23.
//

import SwiftUI

struct HistorySheet: View {
    var history : History
    var body: some View {
        LazyVStack(alignment: .leading, spacing: 10){
            Text("\(history.executionDate.formatted(date: .long, time: .omitted))")
            LazyVStack(alignment: .leading, spacing: 5){
                Text("\(history.yogaDone.first?.name ?? "Unknown Yoga")")
                    .font(.largeTitle.bold())
                Text("\(history.yogaDone.first?.poses.count ?? -1) Exercise (\(history.duration) Min)")
                    .padding(.horizontal, 5)
                    .background(.ultraThinMaterial)
                    .cornerRadius(8)
                    .lineLimit(1)
                    .foregroundStyle(.gray)
            }
            .padding(.bottom, 10)
            ScrollView{
                LazyVStack{
                    if let poses = history.yogaDone.first?.poses {
                        ForEach(poses, id: \.id){ pose in
                            PoseCard(pose: pose)
                        }
                        
                    }else {
                        Text("No Poses to Show")
                    }
                    
                }
                Spacer(minLength: 100)
            }
            
        }
        .padding(.horizontal, 14)
    }
}

//#Preview {
//    let poses = [
//        Pose(id: UUID(), name: "Banana", description: "Banana", seconds: 60, state: .completed, position: .supine, spineMovement: .lateralBend, recommendedTrimester: .all, bodyPartTrained: [.back, .chest, .core], relieve: [.backpain, .neckcramp, .hippain], difficulty: .beginner),
//        Pose(id: UUID(), name: "Bound Angle", description: "Bound Angle", seconds: 60, state: .completed, position: .seated, spineMovement: .neutral, recommendedTrimester: .second, bodyPartTrained: [.shoulders, .legs], relieve: [.hippain, .backpain, .pelvicflexibility], difficulty: .beginner),
//        Pose(id: UUID(), name: "Gracious Pose", description: "Gracious Pose", seconds: 60, state: .notCompleted, position: .seated, spineMovement: .neutral, recommendedTrimester: .all, bodyPartTrained: [.shoulders, .legs], relieve: [.hippain, .backpain], difficulty: .beginner),
//        Pose(id: UUID(), name: "Cat", description: "Cat", seconds: 60, state: .skipped, position: .armLegSupport, spineMovement: .forwardBend, recommendedTrimester: .first, bodyPartTrained: [.back, .neck], relieve: [.backpain, .pelvicflexibility], difficulty: .beginner)
//    
//    ]
//    return HistorySheet(history: History(id: UUID(), yogaDone: [
//        Yoga(id: UUID(), name: "Day 1 Upper Body", poses: poses, day: .monday, estimationDuration: 30, image: "")
//    ], executionDate: Date.now, duration: 30, rating: 5))
//}
