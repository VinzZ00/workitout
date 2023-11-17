//
//  TodayBodyView.swift
//  Mamaste
//
//  Created by Jeremy Raymond on 15/11/23.
//

import SwiftUI

struct TodayBodyView: View {
    @EnvironmentObject var vm: HomeViewModel
    @EnvironmentObject var dm: DataManager
    
    @State var scrollPosition: Day?
    
    var body: some View {
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
}

//#Preview {
//    TodayBodyView()
//}
