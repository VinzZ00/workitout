//
//  YogaPreviewView.swift
//  WorkItOut
//
//  Created by Jeremy Raymond on 07/11/23.
//

import SwiftUI

struct YogaPreviewView: View {
    @EnvironmentObject var vm: HomeViewModel
    var yoga: Yoga
    
    var body: some View {
        VStack(alignment: .leading) {
            
            ScrollView {
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
                    VStack(alignment: .leading) {
                        ForEach(PoseManager.getPosesByCategory(poses: yoga.poses, category: category)) { pose in
                            YogaCardView(name: pose.name, min: pose.seconds)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                }
            }
        }
    }
}

//#Preview {
//    YogaPreviewView()
//}
