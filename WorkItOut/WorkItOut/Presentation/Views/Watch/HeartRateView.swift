//
//  HeartRateView.swift
//  WorkItOut
//
//  Created by Kevin Dallian on 27/10/23.
//

import SwiftUI

struct HeartRateView: View {
    @StateObject var vm = WatchViewModel()
    var body: some View {
        Text("Current Heart Rate")
        Text(vm.message)
        .onChange(of: vm.restart) { oldValue, newValue in
            print(newValue ? "Paused" : "Play")
        }
    }
}

#Preview {
    HeartRateView()
}
