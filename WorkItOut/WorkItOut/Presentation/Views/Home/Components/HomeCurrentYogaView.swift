//
//  HomeCurrentYogaView.swift
//  WorkItOut
//
//  Created by Jeremy Raymond on 04/11/23.
//

import SwiftUI

struct HomeCurrentYogaView: View {
    @EnvironmentObject var vm: HomeViewModel
    var df : DateFormatter {
        var f = DateFormatter();
        f.dateFormat = "EEEE, dd MMMM"
        return f
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            ZStack(alignment: .bottom){
                Image(vm.yoga.poses.isEmpty ? "NoYoga" : "YogaPlanImage")
                VStack(alignment: .leading) {
                    Text("\(df.string(from: vm.selectedDate))")
                        .font(.title3)
                        .bold()
                    if vm.yoga.poses.isEmpty {
                        Text("Take a break, Enjoy Your day!")
                            .font(.largeTitle)
                            .bold()
                            .padding(.vertical)
                    }
                    else {
                        Text(vm.yoga.name)
                            .font(.largeTitle)
                            .bold()
                        Text("\(vm.yoga.poses.count) Exercise (\(vm.yoga.totalDurationMinute()) Min)")
                            .font(.body)
                        ButtonComponent(title: "Start Exercise") {
                            vm.toggleSheet(yoga: vm.yoga)
                        }
                    }
                }
                .frame(width: 300)
                .foregroundStyle(.white)
                .padding()
                .background(.black.opacity(0.85))
                .borderedCorner()
            }        }
        .animation(.easeInOut, value: vm.yoga.poses.isEmpty)
        .borderedCorner()
    }
}

#Preview {
    HomeCurrentYogaView()
}
