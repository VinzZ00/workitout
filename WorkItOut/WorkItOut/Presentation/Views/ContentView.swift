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
//    @State var testFireStore : String = ""
//    var db = FireStoreManager.shared
    
    var body: some View {
//        TestFetchFirebase()
//        CameraView();
        
        AssessmentView()
//        EmptyView()
    }
}

#Preview {
    ContentView()
}
