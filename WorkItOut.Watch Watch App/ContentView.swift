//
//  ContentView.swift
//  WorkItOut.Watch Watch App
//
//  Created by Kevin Dallian on 24/10/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var vm = ViewModel()
    var body: some View {
        VStack{
            Text("\(vm.heartRateManager.heartRate)")
            HStack{
                Button {
                    vm.tappedPauseButton()
                } label: {
                    Image(systemName: vm.pause ? "play.fill" : "pause.fill")
                }
                Button{
                    vm.skipButton()
                } label: {
                    Image(systemName: "chevron.right.to.line")
                }
            }
        }
        .onChange(of: vm.heartRateManager.heartRate, { _, newValue in
            vm.sendDataToPhone(key: WatchConnectivityConstants.heartRate, message: String(newValue))
        })
        .onAppear {
            vm.heartRateManager.authorization()
        }
    }
}

#Preview {
    ContentView()
}
