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
    @State private var hasNoProfile = false
    @State private var isLoading = true
    
    var body: some View {
        ZStack{
            if isLoading {
                EmptyView()
            }else{
                if !dm.hasNoProfile{
                    HomeView()
                }
            }
        }
        .fullScreenCover(isPresented: $dm.hasNoProfile) {
            OnboardingView()
        }
        .onChange(of: dm.savedToCoreData, { _, valueIsTrue in
            if valueIsTrue {
                dm.hasNoProfile = false
//                hasNoProfile = false
            }
        })
        .onAppear {
            Task{
                do {
                    dm.hasNoProfile = try await !dm.loadProfile(moc: moc)
//                    hasNoProfile = try await !dm.loadProfile(moc: moc)
                } catch {
                    dm.hasNoProfile = false
//                    hasNoProfile = false
                }
                isLoading = false
            }
        }
    }
}

#Preview {
    ContentView()
}
