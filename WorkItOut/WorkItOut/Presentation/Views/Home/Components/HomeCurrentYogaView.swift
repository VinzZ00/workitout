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
            if let yoga = vm.yoga {
                ZStack(alignment: .bottom){
                    Image(yoga.poses.isEmpty ? "NoYoga" : "YogaPlanImage")
                    VStack(alignment: .leading) {
                        Text("\(df.string(from: vm.selectedDate))")
                            .font(.title3)
                            .bold()
                        if yoga.poses.isEmpty {
                            Text("Take a break, Enjoy Your day!")
                                .font(.largeTitle)
                                .bold()
                                .padding(.vertical)
                        }
                        else {
                            Text(yoga.name)
                                .font(.largeTitle)
                                .bold()
                            Text("\(yoga.poses.count) Exercise (\(yoga.totalDurationMinute()) Min)")
                                .font(.body)
                            ButtonComponent(title: "Start Exercise") {
                                vm.toggleSheet(yoga: yoga)
                            }
                        }
                    }
                    .frame(width: 300)
                    .foregroundStyle(.white)
                    .padding()
                    .background(.black.opacity(0.85))
                    .borderedCorner()
                }
                .borderedCorner()
            }else{
                ZStack(alignment: .bottom){
                    Image("NoYoga")
                    VStack(alignment: .leading) {
                        Text("\(df.string(from: vm.selectedDate))")
                            .font(.title3)
                            .bold()
                        Text("Take a break, Enjoy Your day!")
                            .font(.largeTitle)
                            .bold()
                            .padding(.vertical)
                    }
                    .frame(width: 300)
                    .foregroundStyle(.white)
                    .padding()
                    .background(.black.opacity(0.85))
                    .borderedCorner()
                }
                .borderedCorner()
            }
        }
        .animation(.easeInOut, value: vm.yoga)
    }
}


#Preview {
    HomeCurrentYogaView()
}
