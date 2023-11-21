//
//  TestScrollView.swift
//  Mamaste
//
//  Created by Jeremy Raymond on 14/11/23.
//

import SwiftUI



struct HomeTabView: View {
    @Binding var selected: TabBarEnum
    
    @Namespace private var tabAnimation
    
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                ForEach(TabBarEnum.allCases, id: \.self) { tab in
                    Button(action: {
                        withAnimation(.easeInOut) {
                            selected = tab
                        }
                    }, label: {
                        VStack(spacing: 8) {
                            ZStack {
                                if selected == tab {
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
                                .bold(tab == selected)
                        }
                        .foregroundColor(tab == selected ? Color.primary : Color.neutral3)
                        .background(tab == selected ? Color.primary.opacity(0.05) : .clear)
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
}

#Preview {
    HomeTabView(selected: .constant(.today))
}
