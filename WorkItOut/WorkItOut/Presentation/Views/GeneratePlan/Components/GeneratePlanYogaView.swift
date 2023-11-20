//
//  GeneratePlanYogaView.swift
//  WorkItOut
//
//  Created by Jeremy Raymond on 07/11/23.
//

import SwiftUI

struct GeneratePlanYogaView: View {
    @EnvironmentObject var dm: DataManager
//    @EnvironmentObject var vm: GeneratePlanViewModel
    let yogaPlan: YogaPlan
    
    @StateObject var yvm: YogaCardViewModel = YogaCardViewModel()
    
    var body: some View {
        VStack {
            if dm.profile!.plan.isEmpty {
                Text("No Plan yet")
            }
            else {
                VStack(alignment: .leading) {
                    ForEach(yogaPlan.yogas) { yoga in
                        VStack(alignment: .leading) {
                            Text(yoga.day.getString())
                                .font(.title3)
                                .bold()
                                .id(yoga.day.getInt())
                            ForEach(PoseManager.existingCategories(poses: yoga.poses), id: \.self) { category in
                                HStack {
                                    Text(category.rawValue)
                                        .font(.subheadline)
                                        .foregroundStyle(Color.neutral3)
                                        .bold()
                                    Rectangle()
                                        .frame(height: 0.5)
                                        .foregroundStyle(Color.neutral6)
                                }
                                
                                ForEach(PoseManager.getPosesByCategory(poses: yoga.poses, category: category)) { pose in
                                    YogaCardView(pose: pose)
                                        .environmentObject(yvm)
                                }
                            }
                        }
                        .padding()
                        .background(.white)
                        .padding(.bottom)
                    }
                }
                .background(Color.background)
                .sheet(isPresented: $yvm.showSheet) {
                    YogaDescriptionView(pose: yvm.currentPose)
                }
            }
        }
    }
}

//#Preview {
//    GeneratePlanYogaView()
//}
