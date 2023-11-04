//
//  HomeButtonView.swift
//  WorkItOut
//
//  Created by Jeremy Raymond on 04/11/23.
//

import SwiftUI

struct HomeButtonView: View {
    var icon: String = "person"
    
    var body: some View {
        Button(action: {}, label: {
            Image(systemName: icon)
                .padding(12)
                .background(Color.background.opacity(0.5))
                .clipShape(.circle)
        })
        .buttonStyle(.plain)
    }
}

#Preview {
    HomeButtonView()
}
