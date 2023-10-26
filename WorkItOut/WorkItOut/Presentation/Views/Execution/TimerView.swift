//
//  TimerView.swift
//  WorkItOut
//
//  Created by Angela Valentine Darmawan on 26/10/23.
//

import SwiftUI

struct TimerView: View {
    @ObservedObject var vm: TimerViewModel
    @State var count = 0
    
    var body: some View {
        ZStack {
            Text("\(vm.currentTime())")
                .font(.title2.bold())
                .foregroundColor(.green)
                .onReceive(vm.timer){ _ in
                    vm.updateCurrentTime()
                }
                .frame(width: 120, height: 80)
                .background(.black)
                .cornerRadius(12)
        }
        .onAppear(perform: {
            vm.startTimer()
        })
    }
}

#Preview {
    TimerView(vm: TimerViewModel())
}
