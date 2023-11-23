//
//  HomePlanView.swift
//  Mamaste
//
//  Created by Jeremy Raymond on 19/11/23.
//

import SwiftUI

struct HomePlanView: View {
    @State var picker: Trimester = .first
    
    var body: some View {
        VStack {
            ZStack {
                VStack {
                    TestGradientRectangle(picker: $picker)
                }
                VStack {
                    PlanExploreHeaderView(title: "Plan")
                    PlanBodyView(picker: $picker)
                }
            }
        }
    }
}

#Preview {
    HomePlanView()
}
