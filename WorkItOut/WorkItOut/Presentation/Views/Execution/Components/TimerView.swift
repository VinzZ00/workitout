//
//  TimerView.swift
//  WorkItOut
//
//  Created by Angela Valentine Darmawan on 26/10/23.
//

import SwiftUI

struct TimerView: View {
    @ObservedObject var vm: TimerViewModel
    @State var time: Double
    
    var body: some View {
        ZStack {
            Text("\(vm.currentTime())")
                .font(.system(size: 60))
                .bold()
                .onReceive(vm.timer){ _ in
                    vm.updateCurrentTime()
                }
        }
        .onAppear(perform: {
            vm.startTimer(time: time)
        })
    }
}

#Preview {
    TimerView(vm: TimerViewModel(), time: 60)
}
