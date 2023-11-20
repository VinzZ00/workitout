//
//  HomeOtherPlansView.swift
//  WorkItOut
//
//  Created by Jeremy Raymond on 04/11/23.
//

import SwiftUI

struct HomeOtherPlansView: View {
    @EnvironmentObject var vm: HomeViewModel
    var yogaPlan: YogaPlan
    var image: String = "HandmadeBack1"
    
    var body: some View {
        Button(action: {
            vm.toggleSheet(yoga: yogaPlan.yogas[0], yogaTitle: yogaPlan.name)
        }, label: {
            HStack {
                Image(image)
                    .resizable()
                    .frame(width: 100, height: 100)
                    .borderedCorner()
                VStack(alignment: .leading) {
                    Text(yogaPlan.name)
                        .font(.title3)
                        .bold()
                    Spacer()
                    Text("\(yogaPlan.yogas[0].poses.count) Exercise (\(yogaPlan.yogas[0].totalDurationMinute()) Min)")
                        .font(.callout)
                        .foregroundStyle(Color.neutral3)
                }
                Spacer()
            }
            .padding(8)
            .background(.white)
            .borderedCorner()
        })
        
    }
}

//#Preview {
//    HomeOtherPlansView(yogaPlan: YogaPlan())
//}
