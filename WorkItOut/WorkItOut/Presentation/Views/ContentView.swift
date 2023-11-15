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
    @State private var isLoading = true
    @State var alert = false
    
    var body: some View {
        ZStack{
            if dm.hasNoProfile {
                OnboardingView()
            }
            if isLoading {
                EmptyView()
            }else{
                if !dm.hasNoProfile{
                    TestHomeView()
                        .environmentObject(dm);
                }
            }
        }
        .onChange(of: dm.savedToCoreData, { _, valueIsTrue in
            if valueIsTrue {
                dm.hasNoProfile = false
            }
        })
        .onAppear {
            Task{
                do {
                    dm.hasNoProfile = try await !dm.loadProfile(moc: moc)
                    print("")
                } catch {
                    dm.hasNoProfile = false
                    print("Masuk try catch di content view")
                }
                isLoading = false
            }
        }
    }
}

#Preview {
    ContentView()
}
