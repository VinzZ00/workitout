//
//  TestTabView.swift
//  Mamaste
//
//  Created by Jeremy Raymond on 15/11/23.
//

import SwiftUI

struct TestTabView: View {
    var body: some View {
        VStack {
            TabView {
                Text("Menu")
                    .tabItem {
                        Label("Menu", systemImage: "list.dash")
                    }

                Text("Order")
                    .tabItem {
                        Label("Order", systemImage: "square.and.pencil")
                    }
            }
        }
        
    }
}

#Preview {
    TestTabView()
}
