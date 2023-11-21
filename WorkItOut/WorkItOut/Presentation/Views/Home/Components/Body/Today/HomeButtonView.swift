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
        Image(systemName: icon)
            .padding(12)
            .background(Color.neutral6.opacity(0.5))
            .clipShape(.circle)
    }
}

#Preview {
    HomeButtonView()
}
