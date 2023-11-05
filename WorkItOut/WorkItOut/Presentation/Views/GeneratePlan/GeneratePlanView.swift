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
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                ScrollView {
                    VStack(alignment: .leading) {
                        HStack {
                            Button(action: {
                                avm.resetTimer()
                                avm.state = .chooseWeek
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
                    DayPickerView(days: dm.profile.daysAvailable, selection: dm.profile.daysAvailable[0])
//                    Rectangle()
//                        .frame(height: 12)
//                        .foregroundStyle(Color.background)
                    if dm.profile.plan.isEmpty {
                        Text("No Plan yet")
                    }
                    else {
                        VStack(alignment: .leading) {
                            ForEach(Array(dm.profile.plan[0].yogas.enumerated()), id: \.element) { index, yoga in
                                VStack {
                                    HStack {
                                        VStack(alignment: .leading) {
                                            Text("Day \(index + 1) - Upper Body")
                                                .font(.title3)
                                                .bold()
                                            Text("\(yoga.day.getString()), \(dm.profile.timeOfDay.getString())")
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
//                                    ForEach(yoga.poses, id: \.self) { pose in
//                                        YogaCardView(name: pose.name)
//                                    }
                                }
                                .padding()
                                .background(.white)
                                .padding(.bottom)
                            }
                        }
                        .background(Color.background)
                    }
                    
                }
                
                VStack {
                    
                    ButtonComponent(title: "Finish") {
                        Task {
//                            var addProfile: AddProfileUseCase = AddProfileUseCase()
//                            
//                            await addProfile.call(profile: dm.profile, context: moc)
//                            
//                            var fetchProfile = FetchProfileUseCase()
//                            
//                            let fetchRes = await fetchProfile.call(context: moc)
//                            
//                            dm.profile = fetchRes.first!
//                            
//                            print(fetchRes.first?.name)
                            
                            finish.toggle()
                        }
                        
                    }
                }
                .padding(.horizontal)
            }
            .navigationDestination(isPresented: $finish, destination: {
                HomeView(vm: HomeViewModel(profile: dm.profile))
            })
            .ignoresSafeArea()
            .navigationBarBackButtonHidden()
        }
    }
}

//#Preview {
//    GeneratePlanView(dm: DataManager())
//}
