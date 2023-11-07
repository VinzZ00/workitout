//
//  ExecutionCompleteView.swift
//  WorkItOut
//
//  Created by Kevin Dallian on 03/11/23.
//

import CoreData
import SwiftUI

struct ExecutionCompleteView: View {
    @Environment(\.managedObjectContext) var moc : NSManagedObjectContext
    @Environment(\.presentationMode) var presentationMode
    @Binding var path : NavigationPath
    @ObservedObject var vm : ExecutionViewModel
    var body: some View {
        VStack(spacing: 60){
            Spacer()
            ZStack{
                RoundedRectangle(cornerRadius: 12)
                    .frame(width: 120, height: 120)
                Text("Placeholder")
                    .foregroundStyle(.white)
            }
            VStack{
                Text("Exercise Completed")
                    .font(.title.bold())
                Text("Yeayy, you made it! You have completed today yoga.")
                    .bold()
                    .frame(width: 350)
                    .foregroundStyle(.gray)
                    .multilineTextAlignment(.center)
            }
            Spacer()
            Button("Back to Home"){
                Task{
                    await vm.savePoses(context: moc)
                }
            }.buttonStyle(BorderedButton())
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    ExecutionCompleteView(path: .constant(NavigationPath()), vm: ExecutionViewModel(yoga: Yoga()))
}
