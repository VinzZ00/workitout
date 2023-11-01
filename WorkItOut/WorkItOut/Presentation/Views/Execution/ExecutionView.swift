//
//  ExecutionView.swift
//  WorkItOut
//
//  Created by Angela Valentine Darmawan on 30/10/23.
//

import SwiftUI
import CoreData

struct ExecutionView: View {
    @Environment(\.managedObjectContext) var moc : NSManagedObjectContext
    @State var vm = ExecutionViewModel()
    @State var currentPose : Pose
    @State var index = 0
    
    var body: some View {
        YogaView(exercise: <#T##String#>, nextExercise: <#T##String#>, time: <#T##Double#>, image: <#T##String#>)
            .onChange(of: vm.index) { _, _ in
                currentPose = vm.yogas[vm.index]
            }
            
    }
}

#Preview {
    ExecutionView()
}
