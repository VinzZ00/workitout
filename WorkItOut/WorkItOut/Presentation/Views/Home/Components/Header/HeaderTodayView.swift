//
//  TestHeaderTodayView.swift
//  Mamaste
//
//  Created by Jeremy Raymond on 15/11/23.
//

import SwiftUI

struct HeaderTodayView: View {
    @EnvironmentObject var vm: HomeViewModel
    @EnvironmentObject var dm : DataManager
    
    @State var weekScrollPosition: Int?
    
    var body: some View {
        VStack {
            ZStack {
                VStack {
                    Image(.todayBackground)
                }
                .ignoresSafeArea()
                VStack {
                    HomeWeekIndicatorView()
                    VStack(spacing: 0) {
                        ScrollView(.horizontal) {
                            LazyHStack {
                                ForEach(1..<32, id: \.self) { week in
                                    HStack {
                                        if let profile = dm.profile {
                                            ForEach(Day.allCases, id: \.self) { day in
                                                DayButtonView(selectedDay: $vm.day, workoutDay: vm.days, day: day, weekXpreg: profile.currentPregnancyWeek, checkedWeek: vm.week)
                                                    .id(day)
                                            }
                                        }
                                    }
                                    .frame(width: UIScreen.main.bounds.width)
                                }
                            }
                            .frame(height: 84)
                            .scrollTargetLayout()
                            
                        }
                        .scrollIndicators(.hidden)
                        .scrollTargetBehavior(.viewAligned)
                        .scrollPosition(id: $weekScrollPosition)
                    }
                }
                
            }
        }
        .onAppear{
            vm.initMonth()
            weekScrollPosition = vm.week
        }
        .onChange(of: vm.week, { oldValue, newValue in
            weekScrollPosition = vm.week
        })
        .onChange(of: weekScrollPosition, { oldValue, newValue in
            if let weekScrollPosition {
                vm.week = weekScrollPosition
            }
            vm.initMonth()
        })
        .background(Color.white)
        
    }
}

//#Preview {
//    HeaderTodayView()
//}
