//
//  TestFetchFirebase.swift
//  WorkItOut
//
//  Created by Kevin Dallian on 31/10/23.
//

import SwiftUI

struct TestFetchFirebase: View {
    @StateObject var vm = TestFetchFirebaseViewModel()
    var body: some View {
        List{
            ForEach(vm.poses, id: \.name){ pose in
                Section(pose.name) {
                    Text("\(pose.altName)")
                    Text("Difficulty : \(pose.difficulty.rawValue)")
                    Text("Position : \(pose.position.rawValue)")
                    Text("Recommended Trimester : \(pose.recommendedTrimester.rawValue)")
                }
            }
            
        }
        .onAppear{
            Task{
                await vm.getPoses()
            }
        }
    }
}

#Preview {
    TestFetchFirebase()
}
