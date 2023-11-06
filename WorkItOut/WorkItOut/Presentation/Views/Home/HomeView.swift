//
//  HomeView.swift
//  WorkItOut
//
//  Created by Jeremy Raymond on 30/10/23.
//

import SwiftUI

struct HomeView: View {
    @StateObject var vm: HomeViewModel = HomeViewModel()
    @Environment(\.managedObjectContext) var moc
    @EnvironmentObject var dm : DataManager
    @State var fetch = FetchProfileUseCase()
    
    var body: some View {
        NavigationStack{
            VStack {
                VStack {
                    HStack {
                        NavigationLink {
                            ProfileView(viewModel: ProfileViewModel(profile: vm.profile))
                        } label: {
                            HomeButtonView(icon: "person")
                        }
                        Spacer()
                        HomeWeekIndicatorView()
                            .environmentObject(vm)
                        Spacer()
                        NavigationLink{
                            HistoryView(vm: HistoryViewModel(histories: vm.profile.histories))
                        } label: {
                            HomeButtonView(icon: "clock.arrow.circlepath")
                        }
                    }
                    .padding(.vertical)
                    
                    HStack {
                        ForEach(Day.allCases, id: \.self) { day in
                            DayButtonView(selectedDay: $vm.day, days: vm.days, day: day)
                        }
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(.white)
                
                ScrollView {
                    HomeCurrentYogaView()
                        .environmentObject(vm)
                    
                    VStack(alignment: .leading) {
                        Text("Exercise that might help you")
                            .font(.title2)
                            .bold()
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(Relieve.allCases, id: \.self) { relieve in
                                    HomeYogaCategoryView(relieve: relieve)
                                        .environmentObject(vm)
                                }
                            }
                        }
                        //                        ForEach(HandmadeYogaPlans.yogaPlans, id: \.id) { yogaPlan in
                        //                            HomeOtherPlansView()
                        //                        }
                        ForEach(0...4, id: \.self) { _ in
                            HomeOtherPlansView()
                        }
                    }
                    .padding()
                }
            }
            .background(Color.background)
            .sheet(isPresented: $vm.sheetToggle, content: {
                YogaDetailView()
            })
            .navigationBarBackButtonHidden()
            .onAppear{
                Task{
                    let profile = await fetch.call(context: moc)
                    print(profile)
                }
            }
        }
    }
    
    
}

//#Preview {
//    HomeView()
//}
