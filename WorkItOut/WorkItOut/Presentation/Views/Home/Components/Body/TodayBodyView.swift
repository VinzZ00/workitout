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
        .animation(.easeInOut, value: vm.day)
        .animation(.easeInOut, value: vm.scrollPosition)
        .onAppear {
//            vm.scrollPosition = vm.day
        }
        .onChange(of: vm.day) { _, _ in
            vm.scrollPosition = vm.day
        }
        .onChange(of: vm.scrollPosition) { _, _ in
            if let scrollPosition = vm.scrollPosition {
                vm.day = scrollPosition
            }
        }
    }
}

//#Preview {
//    TodayBodyView()
//}
