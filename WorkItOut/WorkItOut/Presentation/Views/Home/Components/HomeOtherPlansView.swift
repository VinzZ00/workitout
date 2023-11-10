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
    
    var body: some View {
        Button(action: {
            vm.toggleSheet(yoga: yogaPlan.yogas[0])
        }, label: {
            HStack {
                Rectangle()
                    .frame(width: 100, height: 100)
                    .foregroundStyle(.purple)
                    .borderedCorner()
                VStack(alignment: .leading) {
                    Text(yogaPlan.name)
                        .font(.title3)
                        .bold()
                    Spacer()
                    Text("6 Exercise (60 Min)")
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
