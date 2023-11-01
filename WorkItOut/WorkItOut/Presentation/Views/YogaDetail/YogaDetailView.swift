//
//  YogaDetailView.swift
//  WorkItOut
//
//  Created by Jeremy Raymond on 31/10/23.
//

import SwiftUI
import CoreData

struct YogaDetailView: View {
    
    @State var isPresentedExecution = false
    @Environment(\.managedObjectContext) var moc : NSManagedObjectContext
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .leading) {
                Image(systemName: "xmark")
                Text("Balancing and Grounding")
                Text("5 Exercise (50 Min)")
                ForEach(0...5, id: \.self) { _ in
                    YogaCardView()
                }
                ButtonComponent(title: "Start Now") {
                    self.isPresentedExecution = true
                }
                    .navigationDestination(isPresented: $isPresentedExecution) {
                            ExecutionView()
                            .navigationBarBackButtonHidden(true)
                    }

            }
        }
    }
}

#Preview {
    YogaDetailView()
}
