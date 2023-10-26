//
//  ExecutionView.swift
//  WorkItOut
//
//  Created by Angela Valentine Darmawan on 25/10/23.
//

import SwiftUI

struct ExecutionView: View {
    @EnvironmentObject var vm1: GenerateWorkoutViewModel
    @StateObject var vm: ExecutionViewModel = ExecutionViewModel()
    var idx = 0
    
    var body: some View {
        VStack {
            
            Button {
                
            } label: {
                Text("Next")
            }
        .buttonStyle(.borderedProminent)
        }
    }
}

#Preview {
    ExecutionView()
}
