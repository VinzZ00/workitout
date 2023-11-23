//
//  YogaDescriptionView.swift
//  Mamaste
//
//  Created by Jeremy Raymond on 19/11/23.
//

import SwiftUI

struct YogaDescriptionView: View {
    @State var pose: Pose
    var localizePoseIns = LocalizePoseInstructionUseCase()
    @Environment(\.presentationMode) var presentationMode
    @State var alert : Bool = false;
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center) {
                
                HStack {
                    VStack(alignment: .leading) {
                        Button {
                            self.presentationMode.wrappedValue.dismiss()
                        } label: {
                            ZStack{
                                Circle()
                                    .tint(Color.neutral3.opacity(0.1))
                                    .frame(width: 40)
                                Image(systemName: "xmark")
                                    .foregroundStyle(Color.neutral3)
                                    .font(.system(size: 10))
                                    .bold()
                            }
                        }
                        Text(pose.name)
                            .font(.title.bold())
                        Text("(\(pose.altName))")
                            .font(.title2.bold())
                        Text((YogaNames.poseDesc[pose.altName] ?? YogaNames.poseDesc.first?.value)!)
                            .lineLimit(nil)
                        Text(pose.category.getLocalizedString())
                            .font(.body.bold())
                            .foregroundStyle(Color.primary)
                    }
                    Spacer()
                }
                
                if UIImage(named: pose.name) != nil{
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
                    ForEach((YogaNames.poseInstructions[pose.name] ?? YogaNames.poseInstructions.first?.value)!, id: \.originalString) { instruction in
                        HStack {
                            VStack {
                                Text("\((YogaNames.poseInstructions[pose.name] ?? YogaNames.poseInstructions.first?.value)!.firstIndex(of: instruction)!+1)")
                                    .padding()
                                    .background(Color.background)
                                    .clipShape(Circle())
                                Spacer()
                            }
                            
                            Text(instruction)
                        }
                    }
                }
                
                
                
            }
            .onAppear{
                Task {
                    do {
                        self.pose = try  await self.localizePoseIns.call(poses: [self.pose]).first!
                    } catch {
                        alert = true
                    }
                }
            }
            .alert(isPresented: self.$alert){
                Alert(title: Text("Error"), message: Text("Sorry, There are problem when adjust the pose instruction. please try again"))
            }
            .padding()
        }
        
    }
}

#Preview {
    YogaDescriptionView(pose: Pose(id: UUID()))
}
