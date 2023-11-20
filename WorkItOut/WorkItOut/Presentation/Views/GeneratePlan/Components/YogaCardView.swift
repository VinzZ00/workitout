//
//  YogaCardView.swift
//  WorkItOut
//
//  Created by Jeremy Raymond on 30/10/23.
//

import SwiftUI

struct YogaCardView: View {
    @EnvironmentObject var vm: YogaDetailViewModel
    @EnvironmentObject var yvm: YogaCardViewModel
    
    var pose: Pose = Pose(id: UUID())
    
    var min: Int {
        return pose.seconds/60
    }
    var added: Bool = false
    
//    @State var showSheet: Bool = false
    
    var body: some View {
        Button {
//            showSheet.toggle()
            yvm.toggleSheet(pose: pose)
        } label: {
            HStack {
                VStack {
                    if UIImage(named: pose.name) != nil{
                        PoseImageCard(name: pose.name, width: 70)
                    }else{
                        Rectangle()
                            .foregroundStyle(.purple)
                            .frame(width: 70, height: 70)
                            .clipShape(.rect(cornerRadius: 12))
                    }
                    Spacer()
                }
                VStack(alignment: .leading) {
                    Text("\(pose.name) (\(pose.altName))")
                        .lineLimit(1)
                        .font(.title3)
                        .bold()
                    if added {
                       Text("Added Yoga Pose")
                            .font(.caption)
                            .foregroundStyle(Color.primary)
                            .padding(8)
                            .background(Color.primary.opacity(0.25))
                            .borderedCorner()
                    }
                    Label("\(min) Min", systemImage: "clock")
                        .foregroundStyle(Color.neutral3)
                        .font(.subheadline)
                    Text((YogaNames.poseDesc[pose.altName] ?? YogaNames.poseDesc.first?.value)!)
                        .foregroundStyle(Color.neutral3)
                        .font(.footnote)
                        .lineLimit(2)
                }
            }
        }
//        .sheet(isPresented: $showSheet) {
//            YogaDescriptionView(pose: pose)
//        }
        
    }
}

#Preview {
    YogaCardView(pose: Pose(id: UUID(), name: "Pose Name", altName: "Alt Name", category: .warmUp, difficulty: .beginner, exception: [], recommendedTrimester: .first, relieve: [], status: .necessary, image: nil, video: nil, description: "Untuk meregangkan sisi tubuh samping (panggul,pinggang,rusuk,bahu).", instructions: [], seconds: 60, state: .notCompleted))
}
