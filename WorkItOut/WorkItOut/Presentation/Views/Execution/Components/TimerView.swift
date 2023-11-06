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
        VStack {
            Text("\(vm.currentTime())")
                .font(.system(size: 60))
                .bold()
                .onReceive(vm.timer){ _ in
                    vm.updateCurrentTime()
                }
            HStack{
                Button{
                    vm.startTimer(time: time)
                }label: {
                    Image(systemName: "backward.end.circle")
                        .font(.system(size: 44))
                }
                Button{
                    vm.pauseTimer()
                }label: {
                    Image(systemName: "pause.circle")
                        .font(.system(size: 68))
                }
                .padding(.horizontal, 50)
                
                Button{
                        vm.startTimer(time: time)
                }label: {
                    Image(systemName: "forward.end.circle")
                        .font(.system(size: 44))
                }
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
