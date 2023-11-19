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
                        if let yoga = vm.getYogaByDay(day: day) {
                            HomeCurrentYogaView(yoga: yoga, date: vm.changeDay(day: day))
                                .frame(width: UIScreen.main.bounds.width)
                                .id(day)
                        }else{
                            HomeCurrentYogaView(yoga: nil, date: vm.changeDay(day: day))
                                .frame(width: UIScreen.main.bounds.width)
                                .id(day)
                        }
                    }
                }
                .scrollTargetLayout()
                
            }
            .scrollIndicators(.hidden)
            .scrollTargetBehavior(.viewAligned)
            .scrollPosition(id: $vm.scrollPosition)
        }
        .onChange(of: vm.day) { _, _ in
            withAnimation(.easeInOut) {
                vm.scrollPosition = vm.day
            }
        }
        .onChange(of: vm.scrollPosition) { oldValue, newValue in
            if let scrollPosition = vm.scrollPosition {
                vm.day = scrollPosition
            }
        }
    }
}

//#Preview {
//    TodayBodyView()
//}
