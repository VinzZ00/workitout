//
//  HomeCurrentYogaView.swift
//  WorkItOut
//
//  Created by Jeremy Raymond on 04/11/23.
//

import SwiftUI

struct HomeCurrentYogaView: View {
    @EnvironmentObject var vm: HomeViewModel
    
    let yoga: Yoga?
    
    var df : DateFormatter {
        var f = DateFormatter();
        f.dateFormat = "EEEE, dd MMMM"
        return f
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            if let yogaData = yoga {
                ZStack(alignment: .bottom) {
                    Image("YogaPlanImage")
                    VStack(alignment: .leading) {
                        Text("\(df.string(from: vm.selectedDate))")
                            .font(.title3)
                            .bold()
                        Text(yogaData.name)
                            .font(.largeTitle)
                            .bold()
                        Text("\(yogaData.poses.count) Exercise (\(yogaData.totalDurationMinute()) Min)")
                            .font(.body)
                        if yogaData.yogaState == .completed {
                            ButtonComponent(title: "Completed", color: Color.black.opacity(0.1), textColor: Color.green) {}
                        }
                        else {
                            ButtonComponent(title: "Start Exercise") {
                                vm.toggleSheet(yoga: yogaData)
                            }
                        }
                    }
                    .frame(width: 300)
                    .foregroundStyle(.white)
                    .padding()
                    .background(.black.opacity(0.75).gradient)
                    .borderedCorner()
                }
                .borderedCorner()
            }
            else{
                ZStack(alignment: .bottom) {
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


//#Preview {
//    HomeCurrentYogaView()
//}
