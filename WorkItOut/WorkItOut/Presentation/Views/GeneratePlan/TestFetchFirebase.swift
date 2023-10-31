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
            Text("\(vm.poses.count)")
            ForEach(vm.poses, id: \.name){ pose in
                Text("\(pose.name)")
                Text("\(pose.altName)")
            }
            .padding(.vertical, 20)
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
