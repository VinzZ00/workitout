//
//  GeneratePlanYogaView.swift
//  WorkItOut
//
//  Created by Jeremy Raymond on 07/11/23.
//

import SwiftUI

struct GeneratePlanYogaView: View {
    @EnvironmentObject var dm: DataManager
    @EnvironmentObject var vm: GeneratePlanViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            if !dm.profile!.yogas.isEmpty {
                ForEach(dm.profile!.yogas) { yoga in
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
                                YogaCardView(name: pose.name)
                            }
                        }
                    }
                    .padding()
                    .background(.white)
                    .padding(.bottom)
                }
            }
        }
        .background(Color.background)
    }
}

//#Preview {
//    GeneratePlanYogaView()
//}
