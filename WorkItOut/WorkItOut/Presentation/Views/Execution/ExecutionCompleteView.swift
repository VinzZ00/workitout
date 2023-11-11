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
    @State var alert : Bool = false
    var body: some View {
        VStack(spacing: 60){
            Spacer()
            Image(.completeIllustration)
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
                    do {
                        try await vm.savePoses(context: moc)
                    } catch {
                        self.alert = true
                    }
                    path.removeLast()
                }
                vm.objectWillChange.send()
            }.buttonStyle(BorderedButton())
        }.alert(isPresented: self.$alert){
            Alert(title: Text("Error"), message: Text("Sorry, your yoga poses change is not saved, Please recheck your yoga poses"), dismissButton: .default(Text("OK")))
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    ExecutionCompleteView(path: .constant(NavigationPath()), vm: ExecutionViewModel(yoga: Yoga()))
}
