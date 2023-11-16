//
//  HomeTodayView.swift
//  Mamaste
//
//  Created by Jeremy Raymond on 16/11/23.
//

import SwiftUI

struct HomeTodayView: View {
    @EnvironmentObject var vm: HomeViewModel
    @EnvironmentObject var dm: DataManager
    
    @State private var scrollPosition: Day?
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text("Week \(vm.week) - \(vm.month)")
                            .font(.title3)
                            .bold()
                            
                        Text(vm.getTrimesterRoman())
                            .foregroundStyle(Color.neutral3)
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
                HStack {
                    if let profile = dm.profile {
                        ForEach(Day.allCases, id: \.self) { day in
                            DayButtonView(selectedDay: $vm.day, workoutDay: vm.days, day: day, weekXpreg: profile.currentPregnancyWeek, checkedWeek: vm.week)
                        }
                    }
                }
            }
            
            .padding(.horizontal)
            .padding(.bottom)
            .background(Color.white)
            VStack {
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(Day.allCases, id: \.self) { day in
                            if vm.days.contains(day) {
                                HomeCurrentYogaView(yoga: vm.getYogaByDay(day: day))
                                    .frame(width: UIScreen.main.bounds.width)
                            }
                            else {
                                HomeCurrentYogaView(yoga: nil)
                                    .frame(width: UIScreen.main.bounds.width)
                            }
                        }
                    }
                    .scrollTargetLayout()
                }
                .scrollIndicators(.hidden)
                .scrollTargetBehavior(.viewAligned)
                .scrollPosition(id: $scrollPosition)
            }
        }
        .scrollPosition(id: $scrollPosition)
        .onChange(of: vm.day) { oldValue, newValue in
            withAnimation {
                scrollPosition = vm.day
            }
        }
        .onChange(of: scrollPosition) { oldValue, newValue in
            if let scrollPosition {
                vm.day = scrollPosition
            }
            print(vm.day)
        }
    }
        
}

#Preview {
    HomeTodayView()
}
