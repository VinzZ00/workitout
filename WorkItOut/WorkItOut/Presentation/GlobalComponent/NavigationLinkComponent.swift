//
//  NavigationLinkComponent.swift
//  WorkItOut
//
//  Created by Jeremy Raymond on 31/10/23.
//

import SwiftUI

struct NavigationLinkComponent: View {
    var destination: AnyView
    
    var body: some View {
        NavigationLink {
            destination
        } label: {
            Text("Next")
                .bold()
                .frame(maxWidth: .infinity)
        }
        .foregroundStyle(.white)
        .padding(.vertical, 12)
        .background(.orangePrimary)
        .clipShape(.rect(cornerRadius: 12))
    }
}

//#Preview {
//    NavigationLinkComponent(destination: AnyView(HomeView()))
//}
