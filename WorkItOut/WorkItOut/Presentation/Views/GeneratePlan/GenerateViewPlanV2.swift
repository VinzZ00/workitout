//
//  GenerateViewPlanV2.swift
//  Mamaste
//
//  Created by Elvin Sestomi on 14/11/23.
//

import SwiftUI

private struct ViewOffsetKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}

private struct ScrollOffsetKey: PreferenceKey {
    typealias Value = CGRect
    static var defaultValue: CGRect = CGRect.zero
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}

extension View {
    @ViewBuilder func offset(_ coordinateSpace : AnyHashable, completion : @escaping (CGRect) -> ()) -> some View {
        self.overlay {
            GeometryReader {
                Color.clear.preference(
                    key: ScrollOffsetKey.self,
                    value: $0.frame(in: .named(coordinateSpace)
                                   )
                )
                .onPreferenceChange(
                    ScrollOffsetKey.self,
                    perform: completion
                )
            }
        }
    }
}

struct GenerateViewPlanV2: View {
    @StateObject var vm: GeneratePlanViewModel = GeneratePlanViewModel()
    @EnvironmentObject var avm: AssessmentViewModel
    @Environment(\.managedObjectContext) var moc
    @EnvironmentObject var dm: DataManager
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var alert : Bool = false
    @State var selectedDay : Day = .monday;
    @State var sizes : [CGSize] = []
    
//    @MainActor func addSize(size : CGSize) {
//        self.sizes.append(size)
//    }
    
    var body: some View {
        NavigationStack {
            VStack (alignment: .leading) {
                
                // MARK: Header Section
                VStack {
                    VStack {
                        // MARK: Header Design
                        GeneratePlanHeaderView()
                            .environmentObject(vm)
                        
                        // MARK: Hstack Custom Picker
                        HStack(spacing: 0) {
                            ForEach(dm.profile!.daysAvailable, id : \.self) { day in
                                DayPickView(selected: $selectedDay , day: day)
                                    .environmentObject(vm)
                                    .font(.body)
                            }
                        }
                    }
                    .background(Color.white)
                    
                    // MARK: Content of the yogas by day
                    ScrollViewReader { prox in
                        ScrollView(.vertical, showsIndicators : false) {
                            VStack {
                                ForEach(dm.profile!.yogas) { yoga in
                                    VStack(alignment: .leading) {
                                        Text(yoga.day.getString())
                                            .font(.title3)
                                            .bold()
//                                            .frame(height: 400) // For Development Purpose
                                            ForEach(PoseManager.existingCategories(poses: yoga.poses), id: \.self) { category in
                                                HStack {
                                                    Text(category.rawValue)
                                                        .font(.subheadline)
                                                        .foregroundStyle(Color.neutral3)
                                                        .bold()
                                                    Rectangle()
                                                        .frame(height: 0.5)
                                                        .foregroundStyle(Color.neutral6)
                                                }
                                                
                                                ForEach(PoseManager.getPosesByCategory(poses: yoga.poses, category: category)) { pose in
                                                    YogaCardView(pose: pose)
                                                }
                                            }
                                        
                                    }
                                    // MARK: kalo mau pake geo untuk dapetin gede dari si component, bisa pake yang ini.
//                                    .background {
//                                        GeometryReader { geo in
//                                            Path { path in
//                                                addSize(size: geo.size)
//                                            }
//                                        }
            //                                    }
                                    .id(yoga.day.getInt())
                                    .offset("YogaDaySection") { rect in
                                        let minY = rect.minY
                                        
                                        // MARK: Check whether the view is already scroll down about 10 point offset, in the ScrollOffsetKey.
                                        if (minY < 10 && -minY < (rect.midY/2) && selectedDay.getInt() != yoga.day.getInt()) {
                                            withAnimation(.easeInOut(duration: 0.3)) {
                                                selectedDay =  (minY < 10 && -minY < (rect.midY/2) && selectedDay.getInt() != yoga.day.getInt()) ? yoga.day : selectedDay;
                                            }
                                        }
                                    }
                                }
                            }
                            .padding()
                            .background(Color.white)
                            .padding(.vertical)
                            // MARK: Reset all Size of the view
                            .onAppear {
                                self.sizes = []
                            }
                            
                            // MARK: Auto Scroll feature
                            .onChange(of: vm.scrollTarget) { _, target in
                                if let target = target {
                                    vm.scrollTarget = nil
                                    
                                    withAnimation {
                                        prox.scrollTo(target, anchor: .top)
                                    }
                                }
                            }
                            
                            // MARK: Detect Scroll Behavior to auto Hide Custom Navigation Bar
                            .background(GeometryReader {
                                Color.clear.preference(key: ViewOffsetKey.self, value: -$0.frame(in: .named("scroll")).origin.y)
                            })
                            // MARK: Listening change to the view generated value
                            .onPreferenceChange(ViewOffsetKey.self) {
                                if $0 > 10 {
                                    vm.showHeader = false
                                }
                                else {
                                    vm.showHeader = true
                                }
                            }
                        }
                    }
                    .coordinateSpace(name: "YogaDaySection")
                }
//                .padding(.horizontal, 16)
                VStack {
                    ButtonComponent(title: "Finish") {
                        if avm.savePregDate.saveToUserDefault(currentWeek: avm.currentWeek) {
                            print("userDefault saved successfully")
                        } else {
                            print("user default didn't saved successfully from assessment view")
                        }
                        
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
                .background(Color.white)
            }
            .background(Color.background)
            // MARK: ERROR Handling
            .alert(isPresented: self.$alert){
                Alert(title: Text("Error"), message: Text("Sorry, your Profile is not saved, Please resave your profile"))
            }
            // MARK: init selected day
            .onAppear{
                guard (dm.profile?.daysAvailable[0]) != nil else {
                    self.alert = true;
                    return
                }
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
                if dm.profile != nil {
                    HomeView(vm: HomeViewModel(profile: dm.profile!))
                }
            })
            
        }
    }
}

//#Preview {
//    GenerateViewPlanV2()
//}
