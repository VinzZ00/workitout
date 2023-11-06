//
//  HomeWeekIndicatorView.swift
//  WorkItOut
//
//  Created by Jeremy Raymond on 04/11/23.
//

import SwiftUI


// MARK: Elvin minta tolon bikin calendar
struct HomeWeekIndicatorView: View {
    @EnvironmentObject var vm: HomeViewModel
    @EnvironmentObject var dm : DataManager
    
    var body: some View {
        Button(action: {
            vm.previousWeek()
        }, label: {
            Image(systemName: "chevron.left")
                .foregroundStyle(Color.neutral3)
        })
        VStack {
            Text("Week \(vm.week) - \(vm.month)")
                .font(.title3)
                .bold()
            Text(vm.getTrimesterRoman())
                .foregroundStyle(Color.neutral3)
        }
        Button(action: {
            vm.nextWeek()
        }, label: {
            Image(systemName: "chevron.right")
                .foregroundStyle(Color.neutral3)
        })
    }
}

#Preview {
    HomeWeekIndicatorView()
}
