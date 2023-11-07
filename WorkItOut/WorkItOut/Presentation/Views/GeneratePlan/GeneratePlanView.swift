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
    
    @Binding var hasNoProfile : Bool
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                GeneratePlanHeaderView()
                    .environmentObject(vm)
                
                ScrollViewReader( content: { (proxy: ScrollViewProxy) in
                    ScrollView {
                        GeneratePlanYogaView()
                            .environmentObject(vm)
                            .background(GeometryReader {
                                Color.clear.preference(key: ViewOffsetKey.self,
                                    value: -$0.frame(in: .named("scroll")).origin.y)
                            })
                            .onPreferenceChange(ViewOffsetKey.self) {
                                print("offset >> \($0)")
                                if $0 > 100 {
                                    vm.showHeader = false
                                }
                                else {
                                    vm.showHeader = true
                                }
                            }
                    }
                    .onChange(of: vm.scrollTarget) { target in
                        if let target = target {
                            vm.scrollTarget = nil
                            
                            withAnimation {
                                proxy.scrollTo(target, anchor: .center)
                            }
                        }
                    }
                    .coordinateSpace(name: "scroll")
                })
                VStack {
                    ButtonComponent(title: "Finish") {
                        Task{
                            if let prof = dm.profile {
                                await vm.addProfileToCoreData(profile: prof, moc: moc) // TODO: buang seru
                            }
                        }
                        vm.finish.toggle()
                        hasNoProfile.toggle()
                    }
                    .padding(.horizontal)
                }
            }
            .animation(.default, value: vm.showHeader)
            .navigationBarBackButtonHidden()
            .navigationTitle(vm.showHeader ? "" : "Workout Plan for Beginner")
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
    
    struct ViewOffsetKey: PreferenceKey {
        typealias Value = CGFloat
        static var defaultValue = CGFloat.zero
        static func reduce(value: inout Value, nextValue: () -> Value) {
            value += nextValue()
        }
    }
}

//#Preview {
//    GeneratePlanView(dm: DataManager())
//}
