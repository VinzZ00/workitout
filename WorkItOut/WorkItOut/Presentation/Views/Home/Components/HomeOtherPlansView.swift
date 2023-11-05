//
//  HomeOtherPlansView.swift
//  WorkItOut
//
//  Created by Jeremy Raymond on 04/11/23.
//

import SwiftUI

struct HomeOtherPlansView: View {
    var body: some View {
        HStack {
            Rectangle()
                .frame(width: 100, height: 100)
                .foregroundStyle(.purple)
                .borderedCorner()
            VStack(alignment: .leading) {
                Text("Exercise Plan Name (One time exercise only)")
                    .font(.title3)
                    .bold()
                Spacer()
                Text("6 Exercise (60 Min)")
            }
            Spacer()
        }
        .padding(8)
        .background(.white)
        .borderedCorner()
    }
}

#Preview {
    HomeOtherPlansView()
}
