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
    @Binding var sheetToggle : Bool
    @Binding var nextView : Bool
    @Binding var path : NavigationPath
    var yoga: Yoga
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .leading) {
                Image(systemName: "xmark")
                    .padding(12)
                    .background(Color.background.opacity(0.5))
                    .clipShape(.circle)
                Text("Balancing and Grounding")
                    .font(.largeTitle)
                Text("\(yoga.poses.count) Exercise (\(yoga.estimationDuration) Min)")
                    .foregroundStyle(Color.neutral3)
                ScrollView {
                    ForEach(vm.existingCategories(poses: yoga.poses), id: \.self) { category in
                        HStack {
                            Text(category.rawValue)
                                .font(.subheadline)
                                .foregroundStyle(Color.neutral3)
                                .bold()
                            Rectangle()
                                .frame(height: 0.5)
                                .foregroundStyle(Color.neutral6)
                        }
                        VStack(alignment: .leading) {
                            ForEach(vm.getPosesByCategory(poses: yoga.poses, category: category)) { pose in
                                YogaCardView(name: pose.name, min: pose.seconds)
                            }
                        }
                        
                    }
                }
                ButtonComponent(title: "Start Now") {
                    sheetToggle = false
                    path.append("String")
                }
            }
            .padding()
        }
    }
}

#Preview {
    YogaDetailView(sheetToggle: .constant(false), nextView: .constant(false), path: .constant(NavigationPath()), yoga: Yoga())
}
