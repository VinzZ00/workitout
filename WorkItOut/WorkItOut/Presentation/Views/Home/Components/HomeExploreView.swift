//
//  HomeExploreView.swift
//  Mamaste
//
//  Created by Jeremy Raymond on 19/11/23.
//

import SwiftUI

struct HomeExploreView: View {
    var body: some View {
        VStack {
            ZStack {
                VStack {
//                        Image(.todayBackground)
//                        Spacer()
                }
                .ignoresSafeArea()
                VStack {
                    PlanExploreHeaderView(title: "Explore")
                    ExploreBodyView()
                }
            }
            
        }
    }
}

#Preview {
    HomeExploreView()
}
