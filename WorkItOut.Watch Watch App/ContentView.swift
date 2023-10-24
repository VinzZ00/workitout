//
//  ContentView.swift
//  WorkItOut.Watch Watch App
//
//  Created by Kevin Dallian on 24/10/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var heartRateManager = HeartRateManager()
    var body: some View {
        VStack{
            Text("\(heartRateManager.heartRate)")
        }
        .onAppear {
            heartRateManager.authorization()
        }
    }
}

#Preview {
    ContentView()
}
