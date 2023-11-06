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
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                if showHeader {
                    Text("You are in week 4 of pregnancy, so we are giving you the first trimester yoga plan!")
                        .padding(.horizontal)
                        
                }
                DayPickerView(days: dm.profile.daysAvailable, selection: dm.profile.daysAvailable[0])
                    .environmentObject(vm)
                ScrollViewReader( content: { (proxy: ScrollViewProxy) in
                    ScrollView {
                        VStack {
                            if dm.profile.plan.isEmpty {
                                Text("No Plan yet")
                            }
                            else {
                                VStack(alignment: .leading) {
                                    ForEach(Array(dm.profile.yogaPlan.yogas.enumerated()), id: \.element) { index, yoga in
                                        VStack {
                                            HStack {
                                                VStack(alignment: .leading) {
                                                    Text("Day \(index+1) - Upper Body")
                                                        .font(.title3)
                                                        .bold()
                                                    Text("\(yoga.day.getString()), \(dm.profile.timeOfDay.getString())")
                                                        .foregroundStyle(Color.neutral3)
                                                        .font(.body)
                                                }
                                                .id(yoga.day.getInt())
                                                Spacer()
                                                Button(action: {
                                                    
                                                }, label: {
                                                    Image(systemName: "pencil")
                                                })
                                            }
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
                                                        YogaCardView(name: pose.name)
                                                    }
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
                            if $0 < 1000 {
                                vm.scrollTarget = dm.profile.daysAvailable[0].getInt()
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
                        avm.state = .chooseWeek
                        finish.toggle()
                    }
                }
                .padding(.horizontal)
            }
            .animation(.default, value: showHeader)
            .navigationTitle("Workout Plan for Beginner")
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
                HomeView(vm: HomeViewModel(profile: dm.profile))
            })
            .navigationBarBackButtonHidden()
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
