//
//  PlanExploreHeaderView.swift
//  Mamaste
//
//  Created by Jeremy Raymond on 20/11/23.
//

import SwiftUI

struct PlanExploreHeaderView: View {
    @EnvironmentObject var vm: HomeViewModel
    var title: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(title)
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
    }
}

#Preview {
    PlanExploreHeaderView(title: "Plan")
}
