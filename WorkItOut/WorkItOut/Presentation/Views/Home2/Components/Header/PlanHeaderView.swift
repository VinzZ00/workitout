//
//  TestPlanHeaderView.swift
//  Mamaste
//
//  Created by Jeremy Raymond on 15/11/23.
//

import SwiftUI

struct PlanHeaderView: View {
    @EnvironmentObject var vm: HomeViewModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Plan")
                    .font(.title2.bold())
            }
            Spacer()
            NavigationLink{
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
        .padding(.bottom)
    }
}

#Preview {
    PlanHeaderView()
}
