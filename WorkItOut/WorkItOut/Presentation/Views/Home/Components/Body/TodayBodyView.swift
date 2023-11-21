//
//  TodayBodyView.swift
//  Mamaste
//
//  Created by Jeremy Raymond on 15/11/23.
//

import SwiftUI

struct TodayBodyView: View {
    @EnvironmentObject var vm: HomeViewModel
    @EnvironmentObject var dm: DataManager
    
    @State var scrollPosition: Day?
    
    var body: some View {
        VStack {
            ScrollView(.horizontal) {
                HStack {
                    ForEach(Day.allCases, id: \.self) { day in
                        HomeCurrentYogaView(yoga: vm.getYogaByDay(day: day), date: vm.changeDay(day: day))
                            .frame(width: UIScreen.main.bounds.width)
                    }
                }
                .scrollTargetLayout()
                .onAppear {
                    scrollPosition = vm.day
                }
                
            }
            .scrollIndicators(.hidden)
            .scrollTargetBehavior(.viewAligned)
            .scrollPosition(id: $scrollPosition)
            
        }
        .animation(.easeInOut, value: vm.day)
        .animation(.easeInOut, value: scrollPosition)
        .onAppear {
            scrollPosition = vm.day
        }
        .onChange(of: vm.day) { _, _ in
            scrollPosition = vm.day
        }
        .onChange(of: scrollPosition) { _, _ in
            if let scrollPosition = scrollPosition {
                vm.day = scrollPosition
            }
            print(scrollPosition)
        }
    }
}

//#Preview {
//    TodayBodyView()
//}
