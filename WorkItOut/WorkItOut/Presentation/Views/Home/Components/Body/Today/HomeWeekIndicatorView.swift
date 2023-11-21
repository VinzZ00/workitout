//
//  HomeWeekIndicatorView.swift
//  WorkItOut
//
//  Created by Jeremy Raymond on 04/11/23.
//

import SwiftUI


struct HomeWeekIndicatorView: View {
    @EnvironmentObject var vm: HomeViewModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Week \(vm.week) - \(vm.month)")
                    .font(.title2.bold())
                    .contentTransition(.numericText(value: Double(vm.week)))
                    .animation(.easeInOut, value: vm.week)
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
    }
}

#Preview {
    HomeWeekIndicatorView()
}
