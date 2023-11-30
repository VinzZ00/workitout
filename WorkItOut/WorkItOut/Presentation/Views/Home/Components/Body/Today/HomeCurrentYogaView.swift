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
    let date : Date
    
    var df : DateFormatter {
        let f = DateFormatter();
        f.dateFormat = "EEEE, dd MMMM"
        return f
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            GeometryReader{ proxy in
                if let yogaData = yoga {
                    ZStack(alignment: .bottom) {
                        Image("YogaPlanImage")
                            .resizable()
                            .cornerRadius(12)
                            .frame(width: proxy.size.width * 0.9, height: proxy.size.height)
                            
                        VStack(alignment: .leading) {
                            Text("\(df.string(from: date))")
                                .font(.title3)
                                .bold()
                            Text(yogaData.name)
                                .font(.largeTitle)
                                .bold()
                            Text("\(yogaData.poses.count) Exercise (\(yogaData.totalDurationMinute()) Min)")
                                .font(.body)
                            if vm.week > vm.profile.currentPregnancyWeek {
                                ButtonComponent(title: "Scheduled", color: Color.black.opacity(0.1), textColor: Color.yellow) {}
                            }
                            else if vm.week < vm.profile.currentPregnancyWeek {
                                
                            }
                            else if yogaData.yogaState == .completed {
                                ButtonComponent(title: "Completed", color: Color.black.opacity(0.1), textColor: Color.green) {}
                            }
                            else {
                                ButtonComponent(title: "Start Exercise") {
                                    vm.toggleSheet(yoga: yogaData)
                                }
                            }
                        }
                        .padding()
                        .background(.black.opacity(0.75).gradient)
                        .frame(width: proxy.size.width * 0.85)
                        .foregroundStyle(.white)
                        .borderedCorner()
                    }
                    .frame(width: proxy.size.width)
                }
                else{
                    ZStack(alignment: .bottom) {
                        Image("Empty")
                            .resizable()
                            .cornerRadius(12)
                            .frame(width: proxy.size.width * 0.9, height: proxy.size.height)
                        VStack(alignment: .leading) {
                            Text("\(df.string(from: date))")
                                .font(.title3)
                                .bold()
                            Text("Take a break, Enjoy Your day!")
                                .font(.largeTitle)
                                .bold()
                                .padding(.vertical)
                        }
                        .padding()
                        .background(.black.opacity(0.75).gradient)
                        .cornerRadius(12)
                        .frame(width: proxy.size.width * 0.85)
                        .foregroundStyle(.white)
                    }
                    .frame(width: proxy.size.width)
                }
            }
        }
        .animation(.easeInOut, value: vm.yoga)
    }
}


//#Preview {
//    HomeCurrentYogaView()
//}
