//
//  YogaPreviewView.swift
//  WorkItOut
//
//  Created by Jeremy Raymond on 07/11/23.
//

import SwiftUI

struct YogaPreviewView: View {
    @EnvironmentObject var vm: HomeViewModel
    var oldYoga: Yoga
    var newYoga: Yoga
    
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(PoseManager.existingCategories(poses: newYoga.poses), id: \.self) { category in
                HStack {
                    Text(category.rawValue)
                        .font(.subheadline)
                        .foregroundStyle(Color.neutral3)
                        .bold()
                    Rectangle()
                        .frame(height: 0.5)
                        .foregroundStyle(Color.neutral6)
                }
                VStack(alignment: .leading) {
                    ForEach(PoseManager.getPosesByCategory(poses: newYoga.poses, category: category)) { pose in
                        
                        YogaCardView(pose: pose, added: !oldYoga.poses.contains(pose))
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
            }
            
        }
    }
}

//#Preview {
//    YogaPreviewView()
//}
