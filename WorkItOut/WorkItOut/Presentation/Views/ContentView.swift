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
                if !hasNoProfile{
                    HomeView()
                }
            }
        }.alert(isPresented: $hasNoProfile, content: {
            Alert(title: Text("Error"), message: Text("Error loading your data"), dismissButton: .default(Text("OK")))
        })
        .fullScreenCover(isPresented: $hasNoProfile) {
            AssessmentView(hasNoProfile: $hasNoProfile)
        }
        .onChange(of: dm.savedToCoreData, { _, valueIsTrue in
            if valueIsTrue {
                hasNoProfile = false
            }
        })
        .onAppear {
            Task{
                do {
                    hasNoProfile = try await !dm.loadProfile(moc: moc)
                } catch {
                    hasNoProfile = false
                }
                isLoading = false
            }
        }
    }
}

#Preview {
    ContentView()
}
