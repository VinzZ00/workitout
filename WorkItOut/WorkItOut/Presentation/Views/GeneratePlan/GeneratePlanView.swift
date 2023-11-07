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
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var dm: DataManager
    
    @State var finish: Bool = false
    @State var showHeader: Bool = true
    
//    @State private var offset = CGFloat.zero
    @Binding var hasNoProfile : Bool
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                ZStack {
                    if showHeader {
                        VStack {
                            Image("AssesmentResultHeaderBackground")
                                .resizable()
                                .frame(maxWidth: .infinity)
                                .ignoresSafeArea()
                            Spacer()
                        }
                        
                    }
                    
                    VStack(alignment: .leading) {
                        if showHeader {
                            VStack(alignment: .leading) {
                                Text("Workout Plan for Beginner - New Beginnings")
                                    .font(.largeTitle)
                                    .bold()
                                Text("You are in week 4 of pregnancy, so we are giving you the first trimester yoga plan!")
                            }
                            .padding(.horizontal)
                                
                        }
                        DayPickerView(days: dm.profile!.daysAvailable, selection: dm.profile!.daysAvailable[0])
                            .environmentObject(vm)
                            .padding(.top)
                    }
                }
                
                ScrollViewReader( content: { (proxy: ScrollViewProxy) in
                    ScrollView {
                        VStack {
                            if dm.profile!.plan.isEmpty {
                                Text("No Plan yet")
                            }
                            else {
                                VStack(alignment: .leading) {
                                    ForEach(dm.profile!.yogas) { yoga in
                                        VStack(alignment: .leading) {
                                            Text(yoga.day.getString())
                                                .font(.title3)
                                                .bold()
                                                .id(yoga.day.getInt())
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
                                                
                                                ForEach(vm.getPosesByCategory(poses: yoga.poses, category: category)) { pose in
                                                    YogaCardView(name: pose.name)
                                                }
                                            }
                                        }
                                        .padding()
                                        .background(.white)
                                        .padding(.bottom)
                                    }
                                }
                                .background(Color.background)
                            }
                        }
                        .background(GeometryReader {
                            Color.clear.preference(key: ViewOffsetKey.self,
                                value: -$0.frame(in: .named("scroll")).origin.y)
                        })
                        .onPreferenceChange(ViewOffsetKey.self) { 
                            print("offset >> \($0)")
                            if $0 > 100 {
                                self.showHeader = false
                            }
                            else {
                                self.showHeader = true
                            }
                        }
                    }
                    .onChange(of: vm.scrollTarget) { target in
                        print("Changed")
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
                        finish.toggle()
                        hasNoProfile.toggle()
                    }
                    .padding(.horizontal)
                }
            }
            .animation(.default, value: showHeader)
            .navigationBarBackButtonHidden()
            .navigationTitle(showHeader ? "" : "Workout Plan for Beginner")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        avm.resetTimer()
                        avm.state = .chooseWeek
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "xmark")
                            .font(.body)
                            .padding(8)
                            .background(Color.background.opacity(0.5))
                            .clipShape(.circle)
                    })
                }
            }
            .navigationDestination(isPresented: $finish, destination: {
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
