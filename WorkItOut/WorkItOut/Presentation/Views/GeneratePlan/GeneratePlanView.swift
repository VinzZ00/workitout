//
//  GeneratePlanView.swift
//  WorkItOut
//
//  Created by Jeremy Raymond on 30/10/23.
//

import SwiftUI

struct GeneratePlanView: View {
    @StateObject var vm: GeneratePlanViewModel = GeneratePlanViewModel()
    @EnvironmentObject var avm: AssessmentViewModel
    @Environment(\.managedObjectContext) var moc
    @EnvironmentObject var dm: DataManager
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var alert : Bool = false
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                GeneratePlanHeaderView()
                    .environmentObject(vm)
                GeneratePlanScrollViewBuilder(scrollTarget: $vm.scrollTarget, showContent: $vm.showHeader)
                    .environmentObject(vm)
                    .environmentObject(dm)
//                {
//                    GeneratePlanYogaView()
//                        .environmentObject(vm)
//                }
                VStack {
                    ButtonComponent(title: "Finish") {
                        Task{
                            if let prof = dm.profile {
                                do {
                                    try await vm.addProfileToCoreData(profile: prof, moc: moc)
                                } catch {
                                    
                                }
                            }
                            vm.finish.toggle()
                            dm.hasNoProfile.toggle()
                        }
                    }
                    .padding(.horizontal)
                }
            }.alert(isPresented: self.$alert){
                Alert(title: Text("Error"), message: Text("Sorry, your Profile is not saved, Please resave your profile"))
            }
            .animation(.default, value: vm.showHeader)
            .navigationBarBackButtonHidden()
            .navigationTitle(vm.showHeader ? "" : String(localized: "Workout Plan for Beginner"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    IconButtonComponent(icon: "xmark") {
                        avm.resetTimer()
                        avm.state = .chooseWeek
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .navigationDestination(isPresented: $vm.finish, destination: {
                if let prof = dm.profile {
                    HomeView(vm: HomeViewModel(profile: dm.profile!)) // TODO: buang seru
                }
            })
            
        }
    }
}

//#Preview {
//    GeneratePlanView(dm: DataManager())
//}
