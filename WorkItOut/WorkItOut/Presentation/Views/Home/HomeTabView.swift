//
//  TestScrollView.swift
//  Mamaste
//
//  Created by Jeremy Raymond on 14/11/23.
//

import SwiftUI

struct HomeTabView: View {
    @Binding var selected: TabBarEnum
    
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                ForEach(TabBarEnum.allCases, id: \.self) { tab in
                    Button(action: {
                        withAnimation(.easeInOut) {
                            selected = tab
                        }
                    }, label: {
                        if selected == tab {
                            TabButtonLabel(tab: tab, selected: true)
                        }
                        else {
                            TabButtonLabel(tab: tab, selected: false)
                        }
                    })
                    .frame(maxWidth: 72)
                    .padding(.horizontal, 32)
                    
                }
            }
            .padding(.bottom, 32)
            .frame(maxWidth: .infinity)
            .background(.white)
        }
        .frame(maxWidth: .infinity)
        .background(Color.background)
    }
    
    struct TabButtonLabel: View {
        var tab: TabBarEnum = .today
        @State var selected: Bool = false
        
        @Namespace private var tabAnimation
        let gradient = LinearGradient(gradient: Gradient(colors: [Color.primary, .clear]), startPoint: .top, endPoint: .bottom)
        
        var body: some View {
            VStack(spacing: 8) {
                ZStack {
                    if selected {
                        Rectangle()
                            .frame(maxWidth: .infinity, maxHeight: 2)
                            .matchedGeometryEffect(id: "tabId", in: tabAnimation)
                    }
                    Rectangle()
                        .frame(height: 2)
                        .opacity(0)
                }
                Image(systemName: tab.icon)
                    .font(.body)
                Text(tab.rawValue)
                    .font(.body)
                    .bold(selected)
            }
            .foregroundColor(selected ? Color.primary : Color.neutral3)
            .background(selected ? gradient.opacity(0.05) : gradient.opacity(0))
        }
        
    }
}

#Preview {
    HomeTabView(selected: .constant(.today))
}
