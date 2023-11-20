//
//  TestTabButtonView.swift
//  Mamaste
//
//  Created by Jeremy Raymond on 14/11/23.
//

import SwiftUI

struct TabButtonView: View {
    var tab: TabBarEnum = .today
    @Binding var selected: TabBarEnum
    
    @Namespace private var tabAnimation
    
    var body: some View {
        Button(action: {
            withAnimation(.easeInOut) {
                selected = tab
            }
        }, label: {
            VStack(spacing: 8) {
                if selected == tab {
                    Rectangle()
                        .frame(width: 24, height: 2)
                        .matchedGeometryEffect(id: "tabId", in: tabAnimation)
                }
                Image(systemName: tab.icon)
                Text(tab.rawValue)
                    .font(.title3)
                    .bold(tab == selected)
            }
            .foregroundStyle(tab == selected ? Color.primary : Color.neutral3)
        })
        
    }
}

#Preview {
    TabButtonView(selected: .constant(.today))
}
