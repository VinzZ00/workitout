//
//  YogaCardView.swift
//  WorkItOut
//
//  Created by Jeremy Raymond on 30/10/23.
//

import SwiftUI

struct YogaCardView: View {
    @EnvironmentObject var vm: YogaDetailViewModel
    
    var name: String = "Mountain Pose"
    var altName: String = "Tadasana"
    var description: String = "Help relieve back pain"
    var seconds: Int = 60
    var min: Int {
        return seconds/60
    }
    var added: Bool = false
    
    var body: some View {
        HStack {
            VStack {
                if let image = UIImage(named: name){
                    PoseImageCard(name: name, width: 70)
                }else{
                    Rectangle()
                        .foregroundStyle(.purple)
                        .frame(width: 70, height: 70)
                        .clipShape(.rect(cornerRadius: 12))
                }
                Spacer()
            }
            VStack(alignment: .leading) {
                Text("\(name) (\(altName))")
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
                Text((YogaNames.poseDesc[altName] ?? YogaNames.poseDesc.first?.value)!)
                    .foregroundStyle(Color.neutral3)
                    .font(.footnote)
                    .lineLimit(2)
            }
        }
    }
}

#Preview {
    YogaCardView(name: "Mountain")
}
