//
//  HistorySheet.swift
//  WorkItOut
//
//  Created by Kevin Dallian on 02/11/23.
//

import SwiftUI

struct HistorySheet: View {
    var history : History
    @Binding var showSheet : Bool
    var body: some View {
        VStack(alignment: .leading, spacing: 10){
            Text("\(history.executionDate.formatted(date: .complete, time: .omitted))")
            LazyVStack(alignment: .leading, spacing: 5){
                Text("\(history.yogaDone.name)")
                    .font(.largeTitle.bold())
                Text("\(history.yogaDone.poses.count) Exercise (\(history.duration) Min)")
                    .padding(.horizontal, 5)
                    .background(.ultraThinMaterial)
                    .cornerRadius(8)
                    .lineLimit(1)
                    .foregroundStyle(Color.neutral3)
            }
            .padding(.bottom, 10)
            ScrollView{
                LazyVStack{
                    ForEach(history.yogaDone.poses, id: \.id){ pose in
                        PoseCard(pose: pose)
                    }
                }
                Spacer(minLength: 100)
            }
            
        }
        .padding(.horizontal, 14)
        .toolbar{
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    showSheet = false
                } label: {
                    ZStack{
                        Circle()
                            .foregroundStyle(Color.neutral6.opacity(0.25))
                            .frame(width: 24, height: 24)
                        Image(systemName: "multiply")
                            .foregroundStyle(.black.opacity(0.6))
                            .bold()
                            .font(.system(size: 10))
                    }
                }

                
            }
        }
    }
}

//#Preview {
//    let poses = [
//        Pose(id: UUID(), name: "Banana", difficulty: .beginner, recommendedTrimester: .all, relieve: [.back, .neck, .hip], image: nil, description: "Banana", seconds: 60, state: .completed),
//        Pose(id: UUID(), name: "Bound Angle", difficulty: .beginner, recommendedTrimester: .second, relieve: [.hip, .back], image: nil, description: "Bound Angle", seconds: 60, state: .completed),
//        Pose(id: UUID(), name: "Cat", difficulty: .beginner, recommendedTrimester: .first, relieve: [.back, .pelvic], image: nil, description: "Cat", seconds: 60, state: .skipped)
//    
//    ]
//    return NavigationStack{ 
//        HistorySheet(history: History(id: UUID(), yogaDone: Yoga(id: UUID(), name: "Day 1 Upper Body", poses: poses, day: .monday, estimationDuration: 30, image: "").generateYogaHistory(poseHistory: <#T##[PoseHistory]#>), executionDate: Date.now, duration: 30, rating: 5), showSheet: .constant(true))
//    }
        
//}
