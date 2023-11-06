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
    @Binding var hasNoProfile : Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            ScrollView {
                VStack(alignment: .leading) {
                    HStack {
                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                        }, label: {
                            Image(systemName: "xmark")
                                .foregroundStyle(.white)
                                .bold()
                        })
                        .padding(.bottom)
                        Spacer()
                    }
                    Text("Workout Plan for Beginner")
                        .foregroundStyle(.white)
                        .font(.largeTitle)
                        .bold()
                }
                .padding(.top, 72)
                .padding()
                .background(
                    Image(.assesmentResultHeader)
                        .resizable()
                        .frame(maxWidth: .infinity)
                )
                if let profile = dm.profile {
                    DayPickerView(days: profile.daysAvailable, selection: profile.daysAvailable[0])
                    if profile.plan.isEmpty {
                        Text("No Plan yet")
                    }
                    else {
                        VStack(alignment: .leading) {
                            ForEach(Array(profile.plan[0].yogas.enumerated()), id: \.element) { index, yoga in
                                VStack {
                                    HStack {
                                        VStack(alignment: .leading) {
                                            Text("Day \(index + 1) - Upper Body")
                                                .font(.title3)
                                                .bold()
                                            Text("\(yoga.day.getString()), \(profile.timeOfDay.getString())")
                                                .foregroundStyle(Color.neutral3)
                                                .font(.body)
                                        }
                                        Spacer()
                                        Button(action: {
                                            
                                        }, label: {
                                            Image(systemName: "pencil")
                                        })
                                    }
                                    ForEach(Category.allCases, id: \.self) { category in
                                        if vm.checkCategory(poses: yoga.poses, category: category) {
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
                    }
                    VStack {
                        ButtonComponent(title: "Finish") {
                            Task{
                                await vm.addProfileToCoreData(profile: profile, moc: moc)
                            }
                            finish.toggle()
                            hasNoProfile.toggle()
                        }
                    .onChange(of: vm.scrollTarget) { target in
                        print("Changed")
                        if let target = target {
                            vm.scrollTarget = nil

                            withAnimation {
                                print("called")
                                proxy.scrollTo(target, anchor: .center)
                            }
                        }
                    }

                })
                    }
                    .padding(.horizontal)
                }
                
                
            }
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
        .ignoresSafeArea()
        .navigationBarBackButtonHidden()
    }
    
}

//#Preview {
//    GeneratePlanView(dm: DataManager())
//}
