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
    
    var body: some View {
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
            HStack {
                if let profile = dm.profile {
                    ForEach(Day.allCases, id: \.self) { day in
                        DayButtonView(selectedDay: $vm.day, workoutDay: vm.days, day: day, weekXpreg: profile.currentPregnancyWeek, checkedWeek: vm.week)
                    }
                }
            }
        }
        .onAppear{
            vm.initMonth()
        }
        .padding(.horizontal)
        .padding(.bottom)
        .background(Color.white)
        
    }
}

//#Preview {
//    HeaderTodayView()
//}
