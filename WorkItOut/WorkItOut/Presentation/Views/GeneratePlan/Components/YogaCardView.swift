//
//  YogaCardView.swift
//  WorkItOut
//
//  Created by Jeremy Raymond on 30/10/23.
//

import SwiftUI

struct YogaCardView: View {
    @EnvironmentObject var vm: YogaDetailViewModel
    
    var pose: Pose = Pose(id: UUID())
    
    var min: Int {
        return pose.seconds/60
    }
    var added: Bool = false
    
    @State var showSheet: Bool = false
    
    var body: some View {
        Button {
            showSheet.toggle()
        } label: {
            HStack {
                VStack {
                    if let image = UIImage(named: pose.name){
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
        .sheet(isPresented: $showSheet) {
            ScrollView {
                VStack(alignment: .center) {
                    VStack(alignment: .leading) {
                        Text(pose.name)
                            .font(.title.bold())
                        Text("(\(pose.altName))")
                            .font(.title.bold())
                        Text(pose.description)
                        Text(pose.category.getLocalizedString())
                            .font(.body.bold())
                            .foregroundStyle(Color.primary)
                    }
                    if let image = UIImage(named: pose.name){
                        PoseImageCard(name: pose.name, width: 320)
                    }else{
                        Rectangle()
                            .foregroundStyle(.purple)
                            .frame(width: 320, height: 320)
                            .clipShape(.rect(cornerRadius: 12))
                    }
                    HStack {
                        Spacer()
                        VStack {
                            Text("Difficulty")
                            Text(pose.difficulty.getLocalizedString())
                                .bold()
                        }
                        Spacer()
                        Divider()
                        Spacer()
                        VStack {
                            Text("Trimester")
                            Text(pose.recommendedTrimester.getLocalizedString())
                                .bold()
                        }
                        Spacer()
                    }
                    .padding()
                    .background(Color.background)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    VStack(alignment: .leading) {
                        Text("How to do this pose")
                            .bold()
                        ForEach(0...5, id: \.self) { _ in
                            HStack {
                                VStack {
                                    Text("1")
                                        .padding()
                                        .background(Color.background)
                                        .clipShape(Circle())
                                    Spacer()
                                }
                                
                                Text("Ullamcorper eget nulla facilisi etiam dignissim diam quis enim lobortis, 2 lines example")
                            }
                        }
                    }
                    
                }
                .padding()
            }
            
        }
        
    }
}

#Preview {
    YogaCardView(pose: Pose(id: UUID(), name: "Pose Name", altName: "Alt Name", category: .warmUp, difficulty: .beginner, exception: [], recommendedTrimester: .first, relieve: [], status: .necessary, image: nil, video: nil, description: "Untuk meregangkan sisi tubuh samping (panggul,pinggang,rusuk,bahu).", instructions: [], seconds: 60, state: .notCompleted))
}
