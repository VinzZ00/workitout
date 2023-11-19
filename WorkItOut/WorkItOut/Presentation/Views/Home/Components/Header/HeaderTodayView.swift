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
    
//    @Binding var scrollPosition: Day?
    @State var weekScrollPosition: Int?
    
    var body: some View {
        VStack {
            ZStack {
                VStack {
                    Image(.todayBackground)
//                    Spacer()
                }
                .ignoresSafeArea()
                VStack {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Week \(vm.week) - \(vm.month)")
                                .font(.title2.bold())
                            Text("(\(vm.getTrimesterRoman()))")
                                .foregroundStyle(Color.neutral3)
                                .font(.caption)
                        }
                        Spacer()
                        NavigationLink {
                            HistoryView(vm: HistoryViewModel(histories: vm.profile.histories))
                        } label: {
                            HomeButtonView(icon: "clock.arrow.circlepath")
                        }
                        Button {
                            vm.showProfile = true
                        } label: {
                            HomeButtonView(icon: "person")
                        }
                        
                    }
                    .padding(.horizontal)
                    ScrollView(.horizontal) {
                        HStack {
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
                        .scrollTargetLayout()
                        
                    }
                    .scrollIndicators(.hidden)
                    .scrollTargetBehavior(.viewAligned)
                    .scrollPosition(id: $weekScrollPosition)
//                    Spacer()
                }
                
            }
//            Spacer()
        }
//        .ignoresSafeArea()
//        .padding(.bottom)
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
