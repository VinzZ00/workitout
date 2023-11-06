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
    @EnvironmentObject var vm: HomeViewModel
    var yoga: Yoga
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .leading) {
                Image(systemName: "xmark")
                Text("Balancing and Grounding")
                Text("\(yoga.poses.count) Exercise (\(yoga.estimationDuration) Min)")
                ScrollView {
                    ForEach(Category.allCases, id: \.self) { category in
                        if vm.checkCategory(poses: yoga.poses, category: category) {
                            HStack {
                                Text(category.rawValue)
                                    .font(.subheadline)
                                    .foregroundStyle(Color.neutral3)
                                    .bold()
                                Rectangle()
                                    .frame(height: 0.5)
                                    .foregroundStyle(Color.neutral6)
                            }
                            
                
                        }
                        
                        ForEach(yoga.poses, id: \.self) { pose in
                            if pose.category == category {
                                YogaCardView(name: pose.name, category: (pose.relieve.first ?? .ankle).rawValue, min: pose.seconds)
                            }
                        }
                    }
                }
                
                
                ButtonComponent(title: "Start Now") {
                    self.isPresentedExecution = true
                }
                .navigationDestination(isPresented: $isPresentedExecution) {
                        ExecutionView()
                        .navigationBarBackButtonHidden(true)
                }
            }
            .padding()
        }
    }
}

#Preview {
    YogaDetailView(yoga: Yoga())
}
