//
//  ContentView.swift
//  WorkItOut
//
//  Created by Kevin Dallian on 20/10/23.
//

import SwiftUI

//FirestoreDummy

struct ContentView: View {
    @EnvironmentObject var dm: DataManager
    @Environment(\.managedObjectContext) var moc
    @State var hasNoProfile = true
    var body: some View {
        ZStack{
            if !hasNoProfile{
                HomeView()
            }
        }
        .fullScreenCover(isPresented: $hasNoProfile) {
            AssessmentView(hasNoProfile: $hasNoProfile)
        }
        .onReceive(dm.$profile, perform: { output in
            if dm.savedToCoreData {
                if let _ = output {
                    hasNoProfile = false
                }
            }
        })
        .onChange(of: dm.savedToCoreData, { _, valueIsTrue in
            if valueIsTrue {
                hasNoProfile = false
            }
        })
        .onAppear {
            Task{
                await dm.loadProfile(moc: moc)
            }
        }
    }
}

#Preview {
    ContentView()
}
