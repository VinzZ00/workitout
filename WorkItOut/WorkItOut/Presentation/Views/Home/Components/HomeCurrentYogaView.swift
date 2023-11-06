//
//  HomeCurrentYogaView.swift
//  WorkItOut
//
//  Created by Jeremy Raymond on 04/11/23.
//

import SwiftUI

struct HomeCurrentYogaView: View {
    @EnvironmentObject var vm: HomeViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            VStack(alignment: .leading) {
                Text("Today, 26 October")
                    .font(.title3)
                    .bold()
                Text(vm.yoga.name)
                    .font(.largeTitle)
                    .bold()
                Text("\(vm.yoga.poses.count) Exercise (\(vm.yoga.totalDurationMinute()) Min)")
                    .font(.body)
                ButtonComponent(title: "Start Exercise") {
                    vm.toggleSheet(yoga: vm.yoga)
                }
            }
            .foregroundStyle(.white)
            .padding()
            .background(.black.opacity(0.5))
            .borderedCorner()
        }
        .padding()
        .frame(width: 360, height: 480)
        .background(.purple)
        .borderedCorner()
        .padding(.vertical)
    }
}

#Preview {
    HomeCurrentYogaView()
}
